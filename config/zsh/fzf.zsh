if command -v fzf > /dev/null; then
    if fzf --zsh > /dev/null 2>&1; then
        eval "$(fzf --zsh)"
    elif [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
        source /usr/share/doc/fzf/examples/key-bindings.zsh
        source /usr/share/doc/fzf/examples/completion.zsh
    fi
fi
