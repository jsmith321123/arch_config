#!/bin/bash
entries="Lock\nReboot\nSuspend\nShutdown"
selected=$(echo -e $entries | wofi --style=/home/jsmith/.config/wofi/power-styles.css --dmenu --define=order=default --define=hide_search=true --define=filter_rate=100000000000000 --cache-file="/dev/null")

case $selected in
	Lock)
		exec hyprlock;;
	Reboot)
		exec reboot;;
	Suspend)
		exec systemctl suspend;;
	Shutdown)
		exec systemctl poweroff -i;;
esac
