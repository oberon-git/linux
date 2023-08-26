#!/bin/bash

alias exe='chmod u+x'
alias clip='xclip -sel clip'
alias git='gith' 

apt-update() {
    sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove && sudo apt-get autoclean
}

bin() {
    cp "$1" "$HOME/.linux/bin"
}

