#!/bin/bash

# get the cwd and change directories
cwd="$(pwd)"
s="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
sd="$(dirname "${s}")"
cd "${sd}"

chmod -R u+x .
. sh/common.sh

# parse command line args
verbose=false
skip_install=false
use_rustsh=false

export OPTIND=1
while getopts ":hrsv" option; do
  case $option in
    h) echo "usage: $0 [-h] [-r] [-v] [-s]"; return ;;
    r) use_rustsh=true ;; 
    s) skip_install=true ;;
    v) verbose=true ;;
    ?) echo "error: option -$OPTARG is not implemented"; return ;;
  esac
done
export OPTIND=1

# installing packages
if ! ${skip_install}
then
    packages=$(cat packages/apt-get.txt)
    for package in ${packages}
    do
        if ${verbose}
        then
            sudo apt-get install ${package} -y
        else
            sudo apt-get install ${package} -y > /dev/null
        fi
    done

    for script in packages/*.sh
    do
        if ${verbose}
        then
            . "${script}"
        fi
    done

    if ${verbose}
    then
        apt-update
    else
        apt-update > /dev/null
    fi
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

if ${use_rustsh}
then
    printf "\n. \"\$HOME/.linux/bin/rustsh\"\n" >> "${env}"
fi

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

# restore directory
cd "${cwd}"
