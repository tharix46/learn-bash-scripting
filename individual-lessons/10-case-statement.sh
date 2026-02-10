# #!/usr/bin/env bash

finished=0

while (( finished!=1 )); do
  # these echo statements act like a menu to choose from
  echo "What is your favourite Linux distro?"

  echo "1 - debian"
  echo "2 - ubuntu"
  echo "3 - mint"
  echo "4 - arch"
  echo "5 - something else"
  echo "6 - exit script"

  # read user's input and store in distro variable
  read distro

  # case statement
  # case statement is in the while loop, so it will run until 'finished' equals to 1
  case $distro in
    1) echo "debian is a community distro."
    ;;
    2) echo "ubuntu is beginner friendly."
    ;;
    3) echo "mint is ubuntu based."
    ;;
    4) echo "you use arch btw."
    ;;
    5) echo "there are many distros out there"
    ;;
    6) finished=1
    ;;
    *) echo "you didn't enter a valid value."
  esac
done

echo "Thanks for using the script."