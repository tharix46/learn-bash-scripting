#!/usr/bin/env bash


#helper function
helper () {
  if [[ $# -ne 2 ]]; then 
    echo "usage: ./gh-my.sh <owner> <repo>"
    echo "eg: ./gh-my.sh tharix46 shell-scripting" 
    exit 1
  fi 
}
helper