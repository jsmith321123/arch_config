#!/usr/bin/env sh

# Terminate already running bar instances
killall -q hyprpaper 

# Wait until the processes have been shut down
while pgrep -x hyprpaper >/dev/null; do sleep 1; done

hyprpaper &
