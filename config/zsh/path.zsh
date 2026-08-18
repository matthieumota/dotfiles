for dir in \
    $HOME/.config/composer/vendor/bin \
    $HOME/.local/bin \
    $HOME/.composer/vendor/bin \
    $HOME/.cargo/bin \
    $HOME/go/bin \
    /usr/local/go/bin \
    /opt/homebrew/opt/rustup/bin \
    /opt/homebrew/opt/libpq/bin
do
    [ -d $dir ] || continue
    case ":$PATH:" in *":$dir:"*) continue ;; esac
    export PATH=$dir:$PATH
done
