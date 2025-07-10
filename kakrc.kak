eval %sh{kak-lsp}
lsp-enable

map global user l ':enter-user-mode lsp<ret>' -docstring 'LSP mode'

map global insert <tab> '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>' -docstring 'Select next snippet placeholder'

map global object a '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
map global object <a-a> '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
map global object f '<a-semicolon>lsp-object Function Method<ret>' -docstring 'LSP function or method'
map global object t '<a-semicolon>lsp-object Class Interface Struct<ret>' -docstring 'LSP class interface or struct'
map global object d '<a-semicolon>lsp-diagnostic-object --include-warnings<ret>' -docstring 'LSP errors and warnings'
map global object D '<a-semicolon>lsp-diagnostic-object<ret>' -docstring 'LSP errors'

eval %sh{ kak-tree-sitter -dks --init $kak_session }

declare-option str rosewater "rgb:f5e0dc"
declare-option str flamingo  "rgb:f2cdcd"
declare-option str pink      "rgb:f5c2e7"
declare-option str mauve     "rgb:cba6f7"
declare-option str red       "rgb:f38ba8"
declare-option str maroon    "rgb:eba0ac"
declare-option str peach     "rgb:fab387"
declare-option str yellow    "rgb:f9e2af"
declare-option str green     "rgb:a6e3a1"
declare-option str teal      "rgb:94e2d5"
declare-option str sky       "rgb:89dceb"
declare-option str sapphire  "rgb:74c7ec"
declare-option str blue      "rgb:89b4fa"
declare-option str lavender  "rgb:b4befe"
declare-option str text      "rgb:cdd6f4"
declare-option str subtext1  "rgb:bac2de"
declare-option str subtext0  "rgb:a6adc8"
declare-option str overlay2  "rgb:9399b2"
declare-option str overlay1  "rgb:7f849c"
declare-option str overlay0  "rgb:6c7086"
declare-option str surface2  "rgb:585b70"
declare-option str surface1  "rgb:45475a"
declare-option str surface0  "rgb:313244"
declare-option str base      "rgb:1e1e2e"
declare-option str mantle    "rgb:181825"
declare-option str crust     "rgb:11111b"

set-face global title  "%opt{text}+b"
set-face global header "%opt{subtext0}+b"
set-face global bold   "%opt{maroon}+b"
set-face global italic "%opt{maroon}+i"
set-face global mono   "%opt{green}"
set-face global block  "%opt{sapphire}"
set-face global link   "%opt{blue}"
set-face global bullet "%opt{peach}"
set-face global list   "%opt{peach}"

set-face global Default            "%opt{text},%opt{base}"
set-face global PrimarySelection   "%opt{text},%opt{surface2}"
set-face global SecondarySelection "%opt{text},%opt{surface2}"
set-face global PrimaryCursor      "%opt{crust},%opt{rosewater}"
set-face global SecondaryCursor    "%opt{text},%opt{overlay0}"
set-face global PrimaryCursorEol   "%opt{surface2},%opt{lavender}"
set-face global SecondaryCursorEol "%opt{surface2},%opt{overlay1}"
set-face global LineNumbers        "%opt{overlay1},%opt{base}"
set-face global LineNumberCursor   "%opt{rosewater},%opt{surface2}+b"
set-face global LineNumbersWrapped "%opt{rosewater},%opt{surface2}"
set-face global MenuForeground     "%opt{text},%opt{surface1}+b"
set-face global MenuBackground     "%opt{text},%opt{surface0}"
set-face global MenuInfo           "%opt{crust},%opt{teal}"
set-face global Information        "%opt{crust},%opt{teal}"
set-face global Error              "%opt{crust},%opt{red}"
set-face global DiagnosticError    Error
set-face global DiagnosticWarning  "%opt{yellow}"
set-face global StatusLine         "%opt{text},%opt{mantle}"
set-face global StatusLineMode     "%opt{crust},%opt{yellow}"
set-face global StatusLineInfo     "%opt{crust},%opt{teal}"
set-face global StatusLineValue    "%opt{crust},%opt{yellow}"
set-face global StatusCursor       "%opt{crust},%opt{rosewater}"
set-face global Prompt             "%opt{teal},%opt{base}+b"
set-face global MatchingChar       "%opt{maroon},%opt{base}"
set-face global Whitespace         "%opt{overlay1},%opt{base}+f"
set-face global WrapMarker         Whitespace
set-face global BufferPadding      "%opt{base},%opt{base}"

set-face global value         "%opt{peach}"
set-face global type          "%opt{yellow}"
set-face global variable      "%opt{text}"
set-face global module        "%opt{maroon}"
set-face global function      "%opt{blue}"
set-face global string        "%opt{green}"
set-face global keyword       "%opt{mauve}"
set-face global operator      "%opt{sky}"
set-face global attribute     "%opt{yellow}"
set-face global comment       "%opt{overlay1}+i"
set-face global documentation comment
set-face global meta          "%opt{yellow}"
set-face global builtin       "%opt{red}"

set-face global ts_attribute                    attribute
set-face global ts_comment                      comment
set-face global ts_conceal                      "%opt{mauve}+i"
set-face global ts_constant                     "%opt{peach}"
set-face global ts_constant_builtin_boolean     "%opt{sky}"
set-face global ts_constant_character           "%opt{yellow}"
set-face global ts_constant_macro               "%opt{mauve}"
set-face global ts_constructor                  "%opt{sky}"
set-face global ts_diff_plus                    "%opt{green}"
set-face global ts_diff_minus                   "%opt{red}"
set-face global ts_diff_delta                   "%opt{blue}"
set-face global ts_diff_delta_moved             "%opt{mauve}"
set-face global ts_error                        "%opt{red}+b"
set-face global ts_function                     "%opt{blue}"
set-face global ts_function_builtin             "%opt{blue}+i"
set-face global ts_function_macro               "%opt{mauve}"
set-face global ts_hint                         "%opt{blue}+b"
set-face global ts_info                         "%opt{teal}+b"
set-face global ts_keyword                      "%opt{mauve}"
set-face global ts_keyword_conditional          "%opt{mauve}+i"
set-face global ts_keyword_control_conditional  "%opt{mauve}+i"
set-face global ts_keyword_control_directive    "%opt{mauve}+i"
set-face global ts_keyword_control_import       "%opt{mauve}+i"
set-face global ts_keyword_directive            "%opt{mauve}+i"
set-face global ts_keyword_storage              "%opt{mauve}"
set-face global ts_keyword_storage_modifier     "%opt{mauve}"
set-face global ts_keyword_storage_modifier_mut "%opt{mauve}"
set-face global ts_keyword_storage_modifier_ref "%opt{teal}"
set-face global ts_label                        "%opt{sky}+i"
set-face global ts_markup_bold                  "%opt{peach}+b"
set-face global ts_markup_heading               "%opt{red}"
set-face global ts_markup_heading_1             "%opt{red}"
set-face global ts_markup_heading_2             "%opt{mauve}"
set-face global ts_markup_heading_3             "%opt{green}"
set-face global ts_markup_heading_4             "%opt{yellow}"
set-face global ts_markup_heading_5             "%opt{pink}"
set-face global ts_markup_heading_6             "%opt{teal}"
set-face global ts_markup_heading_marker        "%opt{peach}+b"
set-face global ts_markup_italic                "%opt{pink}+i"
set-face global ts_markup_list_checked          "%opt{green}"
set-face global ts_markup_list_numbered         "%opt{blue}+i"
set-face global ts_markup_list_unchecked        "%opt{teal}"
set-face global ts_markup_list_unnumbered       "%opt{mauve}"
set-face global ts_markup_link_label            "%opt{blue}"
set-face global ts_markup_link_url              "%opt{teal}+u"
set-face global ts_markup_link_uri              "%opt{teal}+u"
set-face global ts_markup_link_text             "%opt{blue}"
set-face global ts_markup_quote                 "%opt{overlay1}"
set-face global ts_markup_raw                   "%opt{green}"
set-face global ts_markup_strikethrough         "%opt{overlay1}+s"
set-face global ts_namespace                    "%opt{blue}+i"
set-face global ts_operator                     "%opt{sky}"
set-face global ts_property                     "%opt{sky}"
set-face global ts_punctuation                  "%opt{overlay1}"
set-face global ts_punctuation_special          "%opt{sky}"
set-face global ts_special                      "%opt{blue}"
set-face global ts_spell                        "%opt{mauve}"
set-face global ts_string                       string
set-face global ts_string_regex                 "%opt{pink}"
set-face global ts_string_regexp                "%opt{pink}"
set-face global ts_string_escape                "%opt{flamingo}"
set-face global ts_string_special               "%opt{blue}"
set-face global ts_string_special_path          "%opt{green}"
set-face global ts_string_special_symbol        "%opt{mauve}"
set-face global ts_string_symbol                "%opt{red}"
set-face global ts_tag                          "%opt{mauve}"
set-face global ts_tag_error                    "%opt{red}"
set-face global ts_text                         "%opt{text}"
set-face global ts_text_title                   "%opt{mauve}"
set-face global ts_type                         type
set-face global ts_type_enum_variant            "%opt{teal}"
set-face global ts_variable                     variable
set-face global ts_variable_builtin             builtin
set-face global ts_variable_other_member        "%opt{teal}"
set-face global ts_variable_parameter           "%opt{maroon}+i"
set-face global ts_warning                      "%opt{yellow}+b"

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

define-command -docstring "Pick a file with fzf" fzf-pick %{
    evaluate-commands %sh{
        if command -v fd >/dev/null 2>&1; then
            list_cmd='fd --type f --hidden --follow'
        else
            list_cmd='find . -type f'
        fi

        if [ -n "${kak_client_env_TMUX}" ]; then
            file=$(eval "$list_cmd" | TMUX="$kak_client_env_TMUX" fzf-tmux -d 20)
        else
            file=$(eval "$list_cmd" | fzf --height 80% --reverse --border)
        fi

        [ -n "$file" ] && printf 'edit -existing -- "%s"\n' "$file"
    }
}

map -docstring "fzf file picker" global user f ': fzf-pick<ret>'

define-command fzf-grep -docstring 'live grep' %{
    evaluate-commands %sh{
        grep_tool="rg"

        if [ "$grep_tool" = "rg" ] && command -v rg >/dev/null 2>&1; then
            reload_cmd="rg --vimgrep --smart-case --color=auto -- {q} || true"
        else
            [ "$grep_tool" != "grep" ] && echo "echo -markup '{Information}''$grep_tool'' not found, falling back to grep.'"
            reload_cmd="grep -RHn --color=auto -- {q} . 2>/dev/null | sed 's/\\([^:]*\\):\\([^:]*\\):/\\1:\\2:1:/' || true"
        fi

        if [ -n "${kak_client_env_TMUX}" ]; then
            selection=$(TMUX="$kak_client_env_TMUX" fzf-tmux -d 20 -- \
                --ansi --delimiter ':' \
                --preview 'bat --color=auto --highlight-line {2} {1} 2>/dev/null || cat {1}' \
                --preview-window 'right,55%,wrap' \
                --bind "change:reload($reload_cmd)+first")
        else
            selection=$(fzf --height=80% \
                --ansi --delimiter ':' \
                --preview 'bat --color=auto --highlight-line {2} {1} 2>/dev/null || cat {1}' \
                --preview-window 'right,55%,wrap' \
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
