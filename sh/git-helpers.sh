#!/bin/bash

push() {
    git add .

    if [ -z "${1}" ]
    then
        git commit -m "${1}"
    else
        git commit -m "commit"
    fi
    
    git push
}
