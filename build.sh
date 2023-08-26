#!/bin/bash

export OPTIND=1
while getopts ":h" option; do
  case $option in
    h) echo "usage: $0 [-h]"; return ;;
    ?) echo "error: option -$OPTARG is not implemented"; return ;;
  esac
done
export OPTIND=1

cd src

# build rust binaries
cd rust
cargo build --release
for package in *
do
    if [[ -d $package ]] && [[ -f $package/src/main.rs ]]
    then
        cp target/release/$package ../../bin
    fi
done

# build go binaries

