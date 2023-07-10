#!/bin/bash

git-push() {
    if [[ ! -d .git ]]
    then 
       echo "must be in root of repository" ; return 1
    fi 

    repo_name=${pwd##*/}
    if [[ -z "${1}" ]]
    then
        commit_message="commit"
    else
        commit_message="${1}"
    fi

    git add .

    git commit -m "${commit_message}"
    
    username=""
    if [ -f "$HOME/.git-username" ]
    then
        username=$(cat "$HOME/.git-username")
    else
        echo "place git username in ~/.git-username to bypass this step"
        echo "enter git username"
        read -r username
    fi
    
    token=""
    if [ -f "$HOME/.git-token" ]
    then
        token=$(cat "$HOME/.git-token")
    else
        echo "place git api token in ~/.git-token to bypass this step"
        echo "enter git api token"
        read -r token
    fi

    git push "https://${token}@github.com/${username}/${repo_name}.git"
}

git-ignore() {
    if [ ! -f .gitignore ]
    then
        if [ ! -d .git ]
        then
            echo "must be in the root of a git repository" ; return 1
        else
            touch .gitignore
        fi
    fi

    for path in "$@"
    do
        if [ -f "${path}" ]
        then
            echo "${path}" >> .gitignore
        elif [ -d "${path}" ]
        then
            if [[ "${path}" == *"/" ]]
            then 
                echo "${path}" >> .gitignore
            else
                echo "${path}/" >> .gitignore
            fi
        else
            echo "${path} does not exist"
        fi
    done
}
