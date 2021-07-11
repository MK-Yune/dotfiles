#!/bin/zsh

mcd() {
	mkdir "$1"
	cd "$1"
}

# cheat.sh
cht.sh() {
	curl "cht.sh/$1"
}
