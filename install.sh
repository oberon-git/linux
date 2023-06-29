#!/bin/bash

# parse command line args
verbose=false

while getopts ":hv" option; do
  case $option in
    h) echo "usage: $0 [-h] [-v]"; exit ;;
    v) verbose=true ;;
    ?) echo "error: option -$OPTARG is not implemented"; exit ;;
  esac
done

# installing packages
packages=$(cat packages.txt)
for package in ${packages}
do
    if ${verbose}
    then
        sudo apt-get install ${package}
    else
        sudo apt-get install ${package} > /dev/null
    fi
done

chmod u+x common.sh
. ./common.sh

# TODO uncomment when done testing
# if ${verbose}
# then
#    upgrade-dist
# else
#    upgrade-dist > /dev/null
# fi

# setting up config files
cp .vimrc ~/.vimrc

# configuring the .linux directory
root="$HOME/.linux"
rm -r -f ${root}
mkdir ${root}

tmp=${root}/tmp
mkdir ${tmp}

cp common.sh "${tmp}"

env=${root}/env
touch ${env}

for file in "${root}/*"
do
	if [[ ${file} != "env" ]]
	then
		echo ". \"${root}/${file}\"" >> ${env}
	fi
done

rm -r -f ${tmp}

bin=${root}/bin
mkdir ${bin}

if [ -d "${bin}" ] && [[ ":$PATH:" != *":${bin}:"* ]]; then
    PATH="${PATH:+"$PATH:"}${bin}"
fi

cp rustsh ${bin}

chmod -R u+x ${root}

cmd=". \"\$HOME/.linux/env\""
bashrc="$HOME/.bashrc"
#exists=$(cat ${bashrc} | grep -Fxqc ${cmd})
#if [[ ${exists} -eq 0 ]]
#then
	echo ${cmd} >> ${bashrc}
#fi

