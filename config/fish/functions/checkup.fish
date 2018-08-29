function checkup

  echo \n"Ready? 🍻"\n

  echo "▶️  Check npm update"\n
  ncu -g
  echo "▶️  Check gem update"\n
  /usr/local/bin/gem outdated
  echo "▶️  Check python 2 update"\n
  /usr/local/bin/python -m pip list --outdated
  echo "▶️  Check python 3 update"\n
  /usr/local/bin/python3.7 -m pip list --outdated
  echo "▶️  Check composer update"\n
  composer global outdated
  echo "▶️  Check default config"\n
  find /usr/local -name "*.default"

  echo \n"Finished! 🎉"\n

end
