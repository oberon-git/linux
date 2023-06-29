#!/bin/bash

# get the cwd and change directories
cwd=$(pwd)
s="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
sd=$(dirname "${s}")
cd ${sd}

chmod -R u+x .

# parse command line args
verbose=false
preserve_dir=false
install_rust=false

while getopts ":hvpr" option; do
  case $option in
    h) echo "usage: $0 [-h] [-v] [-p]"; return ;;
    v) verbose=true ;;
    p) preserve_dir=true ;;
    r) install_rust=true ;;
    ?) echo "error: option -$OPTARG is not implemented"; return ;;
  esac
done

# installing packages
#packages=$(cat packages/apt-get.txt)
#for package in ${packages}
#do
#    if ${verbose}
#    then
#        sudo apt-get install ${package}
#    else
#        sudo apt-get install ${package} > /dev/null
#    fi
#done

if ${install_rust}
then
    . packages/install-rust.sh
fi

#. sh/common.sh

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
printf "#!/bin/bash\n\n" > ${env}

# TODO put PATH logic in env
cp -r sh ${root}/sh
for file in ${root}/sh/*
do
	echo ${file} >> ${env}
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

# run command
. "$HOME/.linux/env"

# remove the linux directory and restore directory
#if ! preserve_dir
#then
#    cd ../ ; rm -r -f ${sd}
#fi
cd ${cwd}
