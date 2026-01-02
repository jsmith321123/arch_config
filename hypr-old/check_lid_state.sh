if [[ $(cat /proc/acpi/button/lid/LID/state | grep -c closed) -eq 1 ]]
then
	hyprctl keyword monitor eDP-1, disable
else
	hyprctl keyword monitor eDP-1, 2880x1800, 1760x1440, 1.80
fi
