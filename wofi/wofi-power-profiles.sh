#!/bin/bash

selected=$(powerprofilesctl list | grep -E "^..\S" | sed 's/^..//' | sed 's/.$//' | wofi --style=/home/jsmith/.config/wofi/power-styles.css --dmenu --define=order=default --define=hide_search=true --define=filter_rate=100000000000000 --cache-file="/dev/null")

powerprofilesctl set $selected
