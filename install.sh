#!/bin/bash

root="$HOME/.linux"
mkdir ${root}

cp common.sh "${root}"

env=${root}/env
touch ${env}

for file in "${root}/*"
do
	if [ ${file} != "env" ]
	then
		echo ". \"${root}/${file}\"" >> ${env}
	fi
done

chmod -R u+x ${root}

cmd=". \"${env}\""
bashrc="$HOME/.bashrc"
if ! grep -Fxq ${cmd} ${bashrc}
then
	echo ${cmd} >> ${bashrc}
fi
