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
