#!/bin/bash

{{ #if dotter.packages.waybar }}
reset_waybar() {
    killall waybar
    waybar &
    disown
}
{{ /if }}

{{ #if dotter.packages.hyprland }}
set_hyprland_border() {
    TOMLQ="{{dotter.current_dir}}/bin/tomlq"
    CONFIG_PATH="{{dotter.current_dir}}/.dotter/global.toml"
    WAL_COLORS=$(cat "$HOME/.cache/wal/colors.json" | jq -r '.colors.color2' | cut -c 2-)
    # Set the hyprland vars

    /bin/cat <<EOM >$CONFIG_PATH
$(/bin/cat $CONFIG_PATH | $TOMLQ '.hyprland.variables."border-color-active" = "'${WAL_COLORS}'ff" | .hyprland.variables."border-color-inactive" = "'${WAL_COLORS}'20"' | yj -jt)
EOM
}
{{ /if }}

if [ -z "$1" ]; then
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
else
    SELECTION="$1"
fi

notify-send "Changing Wallpaper" "Changing Wallpaper to $WALLPAPER_DIR$SELECTION"
swww img "$WALLPAPER_DIR$SELECTION" -t center --transition-fps 165
wal --cols16 -s -t -i $WALLPAPER_DIR$SELECTION

{{ #if dotter.packages.hyprland }}
{{ #if (eq_string use-native-colorscheme "true") }}
{{ #if (arr_inc overrides "hyprland") }}
set_hyprland_border
{{ /if }}
{{ /if }}
{{ #if (eq_string use-native-colorscheme "false") }}
{{ #unless (arr_inc overrides "hyprland") }}
set_hyprland_border
{{ /unless }}
{{ /if }}
{{ /if }}

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
