function bx-switch-php --description "bx-switch-php <php-version>"
  brew unlink php@7.1; brew unlink php@7.2; brew unlink php;

  if [ "71" = "$argv[1]" ]
    brew link --force php@7.1
    return 1
  end

  if [ "72" = "$argv[1]" ]
    brew link --force php@7.2
    return 1
  end

  brew link --force php
end
