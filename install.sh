#!/bin/bash

# get the cwd and change directories
cwd=$(pwd)
s="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
sd=$(dirname "${s}")
cd ${sd}

# parse command line args
verbose=false
preserve_dir=false

while getopts ":hvp" option; do
  case $option in
    h) echo "usage: $0 [-h] [-v] [-p]"; exit ;;
    v) verbose=true ;;
    p) preserve_dir=true ;;
    ?) echo "error: option -$OPTARG is not implemented"; exit ;;
  esac
done

# installing packages
#packages=$(cat packages.txt)
#for package in ${packages}
#do
#    if ${verbose}
#    then
#        sudo apt-get install ${package}
#    else
#        sudo apt-get install ${package} > /dev/null
#    fi
#done

#chmod u+x common.sh
#. ./common.sh

# TODO uncomment when done testing
# if ${verbose}
# then
#    upgrade-dist
# else
#    upgrade-dist > /dev/null
# fi

# setting up config files
rm -f "$HOME/.vimrc"
cp .vimrc "$HOME/.vimrc"

# configuring the .linux directory
root="$HOME/.linux"
rm -r -f ${root}
mkdir ${root}

env=${root}/env
echo "#!/bin/bash" > ${env}

for file in "./sh/*"
do
	tail +2 ${file} >> ${env}
done

cp -r ./bin ${root}/bin 

if [ -d "${root}/bin" ] && [[ ":$PATH:" != *":${root}/bin:"* ]]
then
    export PATH="${PATH:+"$PATH:"}${root}/bin"
fi

chmod -R u+x ${root}

# add command to .bashrc
cmd=". \"\$HOME/.linux/env\""
bashrc="$HOME/.bashrc"
bashrc_content=$(cat ${bashrc})
if [[ "$(cat ${bashrc})" != *"${cmd}"* ]]
then
	echo ${cmd} >> ${bashrc}
fi

# remove the linux directory and restore directory
#if ! preserve_dir
#then
#    cd ../ ; rm -r -f ${sd}
#fi
cd ${cwd}
