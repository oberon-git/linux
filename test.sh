#!/bin/bash

for file in ./sh/*
do 
    echo file=${file}
done

echo pwd=$(pwd)
echo ls=$(ls)
for file in "sh/*"
do
    echo file=${file}
	#tail +2 ${file} >> ${env}
done
