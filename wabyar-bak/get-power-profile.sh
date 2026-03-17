#!/bin/bash

current=$(powerprofilesctl list | grep -E "^\*.\S" | sed 's/^..//' | sed 's/.$//')

case $current in
	power-saver)
		printf 'S';;
	balanced)
		printf 'B';;
	performance)
		printf 'P';;
	*)
		printf "nothing";;
esac
