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

mksh() {
    if [ -z $1 ] 
    then
        echo "usage: mksh filename"
        return 1
    fi

    printf "#!/bin/bash\n" > "$1"
    chmod u+x "$1"
}

