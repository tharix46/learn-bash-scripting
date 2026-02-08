#!/usr/bin/env bash

# check if the file is there, and take action according to the exit code
file=~/.gitconfig
ls -l $file &> /dev/null

# exit code of the above ls -l command can be accessed using '$?'
# success code is 0
# anything else means failure
if (( $? == 0 )); then 
  cat $file
else
  echo "$file file does not exist"
fi


# check if the package is there, and take action according to the exit code
package="fastfetch"
sudo apt install $package >> package-install-result.log 2>> package-install-failure.log

if (( $? == 0 )); then   
  fastfetch
else 
  echo "package installation failed"
fi


# exit code should be checked at the correct place
dir=/notexist

if [[ -d $dir ]]; then  
  echo "exit code at if block: $?"
  echo "$dir directory exists"
else  
  echo "exit code at else block: $?"
  echo "$dir directory does not exist"
fi

echo "exit code at the end: $?"