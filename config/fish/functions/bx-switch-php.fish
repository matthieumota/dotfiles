function bx-switch-php --description "bx-switch-php <php-version>"
  brew unlink php@7.1; brew unlink php@7.2; brew unlink php;

  if [ "71" = "$argv[1]" ]
    brew link --force php@7.1
    # Arch Linux
    # sudo ln -sf /usr/bin/php71 /usr/local/bin/php
    # If want to switch pecl
    # pecl -d php_suffix=71 install <package>
    return 1
  end

  if [ "72" = "$argv[1]" ]
    brew link --force php@7.2
    # sudo ln -sf /usr/bin/php72 /usr/local/bin/php
    return 1
  end

  brew link --force php
  # sudo ln -sf /usr/bin/php /usr/local/bin/php
end
