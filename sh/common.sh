#!/bin/bash

alias xclip='xclip -sel clip'

update-dist() {
    apt-get update && apt-get upgrade -y && apt-get autoremove && apt-get autoclean
}
