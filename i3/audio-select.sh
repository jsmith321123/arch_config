#!/bin/bash
selection=$(pactl --format=json list sinks | jq -rc '.[] | (.index|tostring) + " " + .description' | dmenu -p "Select an output..." -l 4 -fn "monospace:size=12")

if [ -z "$selection" ]; then
	echo "no selection"
else
	selectionarray=($selection)
	pactl set-default-sink ${selectionarray[0]}
fi
