#!/bin/bash

push() {
    if [ $# -eq 0 ]
    then
        echo "usage: $0 repo_name commit_message" ; return
    fi

    repo_name="${1}"
    commit_message="${2}"

    git add .

    if [ -z "${commit_message}" ]
    then
        git commit -m "${commit_message}"
    else
        git commit -m "commit"
    fi
    
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

    git push "https://${token}@github.com/${username}/linux.git"
}
