function checkup

  echo \n"Ready? 🍻"\n

  echo "▶️  Check npm update"\n
  ncu -g
  echo "▶️  Check gem update"\n
  # On Arch Linux, we can remove full path
  /usr/local/bin/gem outdated
  echo "▶️  Check python 2 update"\n
  /usr/local/bin/python -m pip list --outdated
  echo "▶️  Check python 3 update"\n
  /usr/local/bin/python3.7 -m pip list --outdated
  echo "▶️  Check composer update"\n
  composer global outdated
  echo "▶️  Check default config"\n
  # macOS
  find /usr/local -name "*.default"
  # Arch Linux
  find / -regextype posix-extended -regex ".+\.pac(new|save)" 2> /dev/null

  echo \n"Finished! 🎉"\n

end
