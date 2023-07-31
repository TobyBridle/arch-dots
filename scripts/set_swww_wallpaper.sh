#!/bin/bash

{{ #if dotter.packages.waybar }}
reset_waybar() {
    killall waybar
    waybar &
    disown
}
{{ /if }}

WALLPAPER_DIR="$HOME/.config/wallpapers/"
WALLPAPERS=$(find "$WALLPAPER_DIR" -type l -or -type f)
DIR_LEN=${#WALLPAPER_DIR}
wallpapers=""
for wallpaper in $WALLPAPERS; do
    wallpapers+="$(cut -c $DIR_LEN- <<<"$wallpaper")\n"
done

SELECTION=$(echo -e "$wallpapers" | rofi -dmenu -msg "Select a Wallpaper")
if [[ -z "$SELECTION" ]]; then
    exit
fi
notify-send "Changing Wallpaper" "Changing Wallpaper to $WALLPAPER_DIR$SELECTION"
swww img "$WALLPAPER_DIR$SELECTION" -t center --transition-fps 165
wal --cols16 -s -t -i $WALLPAPER_DIR$SELECTION

{{ #if dotter.packages.waybar }}
{{ #if (eq_string use-native-colorscheme "true") }}
{{ #if (arr_inc overrides "waybar") }}
reset_waybar
{{ /if }}
{{ /if }}
{{ #if (eq_string use-native-colorscheme "false") }}
{{ #unless (arr_inc overrides "waybar") }}
reset_waybar
{{ /unless }}
{{ /if }}
{{ /if }}
