#!/bin/bash

chmod -R u+x .
. sh/common.sh

# parse command line args
skip_install=false

export OPTIND=1
while getopts ":hsv" option; do
  case $option in
    h) echo "usage: $0 [-h] [-s]"; return ;;
    s) skip_install=true ;;
    ?) echo "error: option -$OPTARG is not implemented"; return ;;
  esac
done
export OPTIND=1

# installing packages
if ! ${skip_install}
then
    packages=$(cat apt-get.txt)
    for package in ${packages}
    do
        sudo apt-get install ${package} -y
    done

    apt-update
fi

# setting up config files
rm -f "$HOME/.vimrc"
cp .vimrc "$HOME/.vimrc"

# configuring the .linux directory
root="$HOME/.linux"
rm -r -f "${root}"
mkdir "${root}"

cp -r bin "${root}/bin"

env="${root}/env"
cp env "${env}"

for file in sh/*
do
	tail +2 "${file}" >> "${env}"
done

chmod -R u+x "${root}"

# add command to .bashrc
cmd=". \"\$HOME/.linux/env\""
bashrc="$HOME/.bashrc"
if [[ "$(cat "${bashrc}")" != *"${cmd}"* ]]
then
	echo "${cmd}" >> "${bashrc}"
fi

# run command
. "$HOME/.linux/env"

