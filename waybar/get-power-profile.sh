#!/bin/bash

current=$(powerprofilesctl list | grep -E "^\*.\S" | sed 's/^..//' | sed 's/.$//')

case $current in
	power-saver)
		printf 's';;
	balanced)
		printf 'b';;
	performance)
		printf 'p';;
	*)
		printf $current;;
esac
