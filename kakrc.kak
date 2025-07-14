set-option -add global ui_options terminal_assistant=none
# Set up LSP
eval %sh{kak-lsp}
hook global WinSetOption filetype=(rust|python|zig|c|cpp|typst|nix) %{
    lsp-enable-window
    hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
    hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
    hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
    map global user l ':enter-user-mode lsp<ret>' -docstring 'LSP mode'

    map global insert <tab> '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>' -docstring 'Select next snippet placeholder'

    map global object a '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
    map global object <a-a> '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
    map global object f '<a-semicolon>lsp-object Function Method<ret>' -docstring 'LSP function or method'
    map global object t '<a-semicolon>lsp-object Class Interface Struct<ret>' -docstring 'LSP class interface or struct'
    map global object d '<a-semicolon>lsp-diagnostic-object --include-warnings<ret>' -docstring 'LSP errors and warnings'
    map global object D '<a-semicolon>lsp-diagnostic-object<ret>' -docstring 'LSP errors'
}
hook -group lsp-filetype-rust global BufSetOption filetype=rust %{
    set-option buffer lsp_servers %{
        [rust-analyzer]
        root_globs = ["Cargo.toml"]
        single_instance = true
        [rust-analyzer.experimental]
        commands.commands = ["rust-analyzer.runSingle"]
        hoverActions = true
        [rust-analyzer.settings.rust-analyzer]
        # See https://rust-analyzer.github.io/manual.html#configuration
        # cargo.features = []
        check.command = "clippy"
        [rust-analyzer.symbol_kinds]
        Constant = "const"
        Enum = "enum"
        EnumMember = ""
        Field = ""
        Function = "fn"
        Interface = "trait"
        Method = "fn"
        Module = "mod"
        Object = ""
        Struct = "struct"
        TypeParameter = "type"
        Variable = "let"
    }
}

# Set up tree-sitter
eval %sh{ kak-tree-sitter --with-highlighting --with-text-objects -dks --init $kak_session }

# Fuzzy pickers
define-command -docstring "Pick a file with fzf" fzf-pick %{
    evaluate-commands %sh{
        if [ -n "${kak_client_env_TMUX}" ]; then
            file=$(
                rg --files --hidden --follow --glob '!.git/*' | while IFS= read -r path; do
      		          basename="${path##*/}"
      		          dirname="${path%/*}"
      		          if [ "$dirname" = "$path" ]; then
      		            echo "$(tput bold)$basename$(tput sgr0)"
      		          else
      		            echo "$(tput setaf 244)$dirname/$(tput sgr0)$(tput bold)$basename$(tput sgr0)"
      		          fi
      		      done |
                fzf-tmux \
                  -d 20 \
                  --ansi \
                  --preview="bat --style=numbers --color=always {}"
            )
        else
            file=$(
                rg --files --hidden --follow --glob '!.git/*' | while IFS= read -r path; do
                    basename="${path##*/}"
                    dirname="${path%/*}"
                    if [ "$dirname" = "$path" ]; then
                      echo "$(tput bold)$basename$(tput sgr0)"
                    else
                      echo "$(tput setaf 244)$dirname/$(tput sgr0)$(tput bold)$basename$(tput sgr0)"
                    fi
                done |
                fzf \
                  --ansi \
                  --preview="bat --style=number --color=always {}" \
                  --height 80% \
                  --reverse \
                  --border
            )
        fi

        [ -n "$file" ] && printf 'edit -existing -- "%s"\n' "$file"
    }
}

map -docstring "fzf file picker" global user f ': fzf-pick<ret>'

define-command fzf-grep -docstring 'live grep' %{
    evaluate-commands %sh{
        grep_tool="rg"

        if [ "$grep_tool" = "rg" ] && command -v rg >/dev/null 2>&1; then
            reload_cmd="rg --vimgrep --smart-case --color=always -- {q} || true"
        else
            [ "$grep_tool" != "grep" ] && echo "echo -markup '{Information}''$grep_tool'' not found, falling back to grep.'"
            reload_cmd="grep -RHn --color=auto -- {q} . 2>/dev/null | sed 's/\\([^:]*\\):\\([^:]*\\):/\\1:\\2:1:/' || true"
        fi

        if [ -n "${kak_client_env_TMUX}" ]; then
            selection=$(TMUX="$kak_client_env_TMUX" fzf-tmux -d 20 -- \
                --ansi \
                --delimiter ':' \
                --preview 'bat --color=always --style=numbers --highlight-line {2} {1} 2>/dev/null' \
                --preview-window 'right:65%:wrap:+{2}-3' \
                --bind "change:reload($reload_cmd)+first")
        else
            selection=$(fzf --height=80% \
                --ansi --delimiter ':' \
                --preview 'bat --color=always --highlight-line --style=numbers {2} {1} 2>/dev/null' \
                --preview-window 'right:65%:wrap:+{2}-3' \
                --bind "change:reload($reload_cmd)+first")
        fi

        if [ -n "$selection" ]; then
            file_path=$(printf '%s\n' "$selection" | cut -d: -f1)
            line_num=$(printf '%s\n' "$selection" | cut -d: -f2)
            col_num=$(printf '%s\n' "$selection" | cut -d: -f3)

            printf 'edit -existing -- "%s" %s %s\n' "$file_path" "$line_num" "$col_num"
        fi
    }
}

map global user g ': fzf-grep<ret>' -docstring 'fzf grep'

# Default colorscheme

# Code highlighting
face global value     bright-magenta
face global type      bright-yellow
face global variable  bright-blue
face global module    bright-yellow
face global function  bright-green+b
face global string    bright-green+i
face global keyword   bright-red
face global operator  bright-blue
face global attribute yellow
face global comment   white+dai
face global meta      bright-cyan
face global builtin   default+b

# Markup
face global title         bright-green+b
face global header        bright-blue+b
face global bold          default,default+ba
face global italic        default,default+ia
face global underline     default,default+ufa
face global strikethrough default,default+sa
face global mono          white
face global block         white
face global link          bright-magenta+u
face global bullet        bright-cyan

face global Default            default,default
face global PrimarySelection   default,bright-black+g
face global PrimaryCursor      black,bright-white+fg
face global PrimaryCursorEol   black,bright-white+fg
face global SecondarySelection default,bright-black+g
face global SecondaryCursor    black,white+fg
face global SecondaryCursorEol black,white+fg
face global LineNumbers        bright-black
face global LineNumberCursor   yellow
face global LineNumbersWrapped black
face global MenuForeground     bright-white,black+b
face global MenuBackground     white,bright-black
face global MenuInfo           bright-blue
face global Information        bright-white,bright-black
face global Error              bright-red,default+b
face global StatusLine         white,bright-black
face global StatusLineMode     cyan
face global StatusLineInfo     green
face global StatusLineValue    bright-red
face global StatusCursor       black,bright-white
face global Prompt             default
face global MatchingChar       blue,default+b
face global BufferPadding      black,default
face global Whitespace         bright-black+f

# Plugins
declare-user-mode surround
map global surround s ':surround<ret>' -docstring "Surround selected text"
map global surround c ':change-surround<ret>' -docstring "Change selected text's surroundings"
map global surround d ':delete-surround<ret>' -docstring "Delete selected text's surroundings"
map global surround t ':select-surrounding-tag<ret>' -docstring "Select selected text's surrounding tags"
map global normal ^ ':enter-user-mode surround<ret>'

hook global WinCreate .* %{
  enable-auto-pairs
}
