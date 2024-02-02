if [[ $(cat /proc/acpi/button/lid/LID0/state | grep -c closed) -eq 1 ]]
then
	hyprctl keyword monitor "eDP-1, disable"
else
	hyprctl keyword monitor "eDP-1, 1920x1200, 0x0, 1.00"
fi
