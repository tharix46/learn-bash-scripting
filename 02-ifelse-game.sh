#!/usr/bin/env bash

#########################################
# this script is a simple game to understand if elif statements in bash
# where the user has to guess numbers to defeat beasts
# to run this script: 
# 1. Ensure the script has executable permissions: chmod +x 02-ifelse-game.sh
# 2. Execute the script: ./02-ifelse-game.sh
#########################################

echo -e "\nWelcome to the Beast Game!\n"

# beast 1
echo -e "approaching the first beast...\n"
sleep 1
echo "You have to choose a number to defeat the beast."

beast1_num=$((RANDOM % 2))

echo -n "Choose a number (0/1): "
read -r user_num1  

if ! [[ $user_num1 =~ ^[01]$ ]]; then
    echo "Invalid input. Number should be 0 or 1."
    exit 1
elif [[ $user_num1 -eq $beast1_num ]]; then
    echo -e "Congratulations! You Won!\n"
else
    echo "Sorry, you died. Correct number was $beast1_num."
    exit 1 
fi

# beast 2
echo -e "approaching the second beast...\n"
sleep 1 
echo "You have to choose a number to defeat the beast."

beast2_num=$((RANDOM % 3))
#echo "beast number is $beast2_num"

echo -n "Choose a number (0-2): "
read -r user_num2

if ! [[ $user_num2 =~ ^[0-2]$ ]]; then
    echo "Invalid input. Number should be 0,1 or 2."
    exit 1
elif [[ $user_num2 -eq $beast2_num ]]; then
    echo "Congratulations! You Won the Game!"
# Special condition: If the user is root, they automatically win regardless of the number chosen.
elif [[ $user_num2 -ne $beast2_num ]] && [[ $USER == "root" ]]; then
    echo "Root user always wins!"
else
    echo "Sorry, you died. Correct number was $beast2_num."
    exit 1
fi