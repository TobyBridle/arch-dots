#!/bin/bash

WALLPAPER_DIR="$HOME/.config/wallpapers/"
WALLPAPERS=$(find "$WALLPAPER_DIR" -type l -or -type f)
DIR_LEN=${#WALLPAPER_DIR}
wallpapers=""
for wallpaper in $WALLPAPERS; do
    wallpapers+="$(cut -c $DIR_LEN- <<<"$wallpaper")\n"
done

SELECTION=$(echo -e "$wallpapers" | rofi -dmenu -msg "Select a Wallpaper")
notify-send "Changing Wallpaper" "Changing Wallpaper to $WALLPAPER_DIR$SELECTION"
swww img "$WALLPAPER_DIR$SELECTION" -t wipe
