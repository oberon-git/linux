#!/bin/bash

root="$HOME/.linux"
rm -r -f ${root}
mkdir ${root}

cp common.sh "${root}"

env=${root}/env
touch ${env}

for file in "${root}/*"
do
	if [[ ${file} != "env" ]]
	then
		echo ". \"${root}/${file}\"" >> ${env}
	fi
done

chmod -R u+x ${root}

cmd=". \"\$HOME/.linux/env\""
bashrc="$HOME/.bashrc"
#exists=$(cat ${bashrc} | grep -Fxqc ${cmd})
#if [[ ${exists} -eq 0 ]]
#then
	echo ${cmd} >> ${bashrc}
#fi
