#!/bin/bash

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
{{ #if (eq_string use-native-colorscheme "false") }}
wal --cols16 -s -t -i $WALLPAPER_DIR$SELECTION
{{ #if dotter.packages.waybar }}
WAL_WAYBAR_COLORS=$(cat ~/.cache/wal/colors-waybar.css)
WAYBAR_CFG="$(cat ~/.config/waybar/style.css | sed -n "1,/@define-color \(shadow\|color15\)/d; /./p")"
NEW_CFG=$(printf "%s\n%s" "${WAL_WAYBAR_COLORS}" "${WAYBAR_CFG}")
printf "%s" "$NEW_CFG" >~/.config/waybar/style.css
killall waybar
waybar &
disown
{{ /if }}
{{ /if }}
