function bx-switch-php --description "bx-switch-php <php-version>"
  brew unlink php@7.2; brew unlink php@7.3; brew unlink php;

  if [ "72" = "$argv[1]" ]
    brew link --force php@7.2
    # Arch Linux
    # sudo ln -sf /usr/bin/php72 /usr/local/bin/php
    # sudo ln -sf /usr/bin/php-config72 /usr/local/bin/php-config
    # sudo ln -sf /usr/bin/phpize72 /usr/local/bin/phpize

    # wget https://pecl.php.net/get/imagick-3.4.4.tgz
    # tar xf imagick-3.4.4.tgz
    # cd imagick-3.4.4.tgz
    # phpize
    # ./configure --with-php-config=php-config
    # make

    return 0
  end

  if [ "73" = "$argv[1]" ]
    brew link --force php@7.3
    # sudo ln -sf /usr/bin/php73 /usr/local/bin/php
    # sudo ln -sf /usr/bin/php-config73 /usr/local/bin/php-config
    # sudo ln -sf /usr/bin/phpize73 /usr/local/bin/phpize
    return 0
  end

  brew link --force php
  # sudo ln -sf /usr/bin/php /usr/local/bin/php
  # sudo ln -sf /usr/bin/php-config /usr/local/bin/php-config
  # sudo ln -sf /usr/bin/phpize /usr/local/bin/phpize
end
