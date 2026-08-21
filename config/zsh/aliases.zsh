# Misc
alias c="clear"
alias e="exit"
alias ff="fastfetch"

# ls
if command -v eza > /dev/null; then
    alias ls="eza --group-directories-first --icons=auto --git"
    alias lt="ls --tree --level=2"
fi

# Symfony
alias sf="php bin/console"

# Laravel
alias artisan="php artisan"
alias mf="php artisan migrate:fresh"
alias mfs="php artisan migrate:fresh --seed"

# JS
# alias watch="npm run watch"

# Git
alias commit="git add . && git commit -m"
alias gb="git branch"
alias gc="git checkout"
alias gl="git log --oneline"
alias gst="git status"
alias push="git push"

stripe() {
    local flags=(--rm -i --network host -v "$HOME/.config/stripe:/root/.config/stripe" -v "$PWD:$PWD" -w "$PWD")
    [ -t 0 ] && [ -t 1 ] && flags+=(-t)
    docker run "${flags[@]}" stripe/stripe-cli "$@"
}
