#!/bin/bash
new() {
	cargo new ${1} ; cd ${1}
}

alias run='cargo run'

