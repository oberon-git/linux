#!/bin/bash

alias xclip='xclip -sel clip'

apt-update() {
    sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove && sudo apt-get autoclean
}

bin() {
    cp "$1" "$HOME/.linux/bin"
}

