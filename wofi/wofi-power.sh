#!/bin/bash

volume="Volume: $(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print tolower($5)}')"

date_time="$(date '+%H:%M %A %d %B %Y')"

current_input_mode="$(if [[ `fcitx5-remote -q` = "Group 1" ]]; then echo "English"; else echo "Japanese"; fi)"

hypridle_entry="$(if [[ $(ps -a | grep hypridle -c) = "0" ]]; then echo 'Enable'; else echo 'Disable'; fi) Hypridle"

entries="$(echo $volume)\n$(echo $date_time)\n$(echo $hypridle_entry)\nCurrent Input: $(echo $current_input_mode)\nSuspend\nShutdown"
selected=$(echo -e $entries | wofi --style=/home/jsmith/.config/wofi/power-styles.css --width=400 --height=100% --dmenu --define=order=default --define=location=top_left --define=hide_search=true --define=filter_rate=100000000000000 --cache-file="/dev/null")

case $selected in
	'Volume:'*)
		exec pavucontrol &;;
	'Current Input:'*)
		exec /home/jsmith/.config/hypr/switch_input.sh &;;
	"Enable Hypridle")
		exec hypridle &;;
	"Disable Hypridle")
		pkill hypridle;;
	Suspend)
		exec systemctl suspend;;
	Shutdown)
		exec systemctl poweroff -i;;
esac
