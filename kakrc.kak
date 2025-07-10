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
