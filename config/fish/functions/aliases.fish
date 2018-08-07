function bx-switch-php --description "bx-switch-php <php-version>"
  brew unlink php@5.6; brew unlink php@7.1; brew unlink php;

  if [ "56" = "$argv[1]" ]
    brew link --force php@5.6
    return 1
  end

  if [ "71" = "$argv[1]" ]
    brew link --force php@7.1
    return 1
  end

  brew link --force php
end
