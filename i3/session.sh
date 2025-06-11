entries="Lock\nSuspend\nReboot\nShutdown"
selected=$(echo -e $entries | dmenu -fn "monospace:size=12" -l 4 -p "Session options")

case $selected in
	Lock)
		exec slock;;
	Suspend)
		exec systemctl suspend;;
	Reboot)
		exec reboot;;
	Shutdown)
		exec systemctl poweroff -i;;
esac
