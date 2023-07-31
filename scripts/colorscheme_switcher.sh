#!/bin/env sh

DOTTER_CONF="{{dotter.current_dir}}/.dotter/global.toml"
TOMLQ="{{dotter.current_dir}}/bin/tomlq"
# If you are that stupid that you have a "" in your colorschemes, uncomment the below
#THEME=$(/bin/cat $DOTTER_CONF | tomlq -c .global.variables.theming | sed -E 's/\{"colorschemes":\W?\[(".+"\W?|".+",\W?)*\]\}/\1/' | tr ',' '\n' | cut -d '"' -f2 | grep "\S" | rofi -dmenu)
# THEME=$(/bin/cat $DOTTER_CONF | tomlq -c .global.variables.theming | sed -E 's/\{"colorschemes":\W?\[(".+"\W?|".+",\W?)*\]\}/\1/' | tr ',' '\n' | cut -d '"' -f2 | rofi -dmenu -theme "~/.config/rofi/styles/theme-selector.rasi")
BASE=$(echo $HOME | sed "s/\//\\//g")
THEME=$(/bin/cat $DOTTER_CONF | $TOMLQ -c .global.variables.theming | sed -E 's/\{"colorschemes":\s?\[(".+"\s?|".+",\s?)*\]\}/\1/' | tr ',' '\n' | while read -r theme; do
    fp=$(/bin/cat "$DOTTER_CONF" | $TOMLQ ".$(echo "$theme" | tr -d '\"').variables.default_wallpaper" | tr -d '"' | sed -E "s;^~/;$BASE/;")
    stripped=$(basename $fp)
    if [[ ! -f /tmp/${stripped%.*}.jpg ]]; then
        convert $fp -thumbnail 500x500^ -gravity center -extent 500x500 /tmp/${stripped%.*}.jpg
    fi
    printf "%s\x00icon\x1f%s\n" $(echo $theme | tr -d '"') /tmp/${stripped%.*}.jpg
done | rofi -dmenu -theme ~/.config/rofi/styles/theme-selector.rasi)

if [[ -z "$THEME" ]]; then
    notify-send "Theme Switcher" "Aborting. Changes not saved."
    exit
fi

/bin/cat <<EOM >$DOTTER_CONF
$(/bin/cat $DOTTER_CONF | $TOMLQ ".colorscheme.depends=[\"$THEME\"]" | yj -jt)
EOM

WALLPAPER=$(/bin/cat $DOTTER_CONF | $TOMLQ ."$THEME".variables | sed -nE 's/"default_wallpaper":\s*"(.+)"(,?)/\1/p')
WALLPAPER_FILE=$(echo $WALLPAPER | sed -E "s;~;$BASE;")
swww img "$WALLPAPER_FILE" -t center --transition-fps 165
killall {{ noti_manager }}
noti_manager &
{{ #if dotter.packages.waybar }}
killall waybar
waybar &
{{ /if }}

{{ #if dotter.packages.vencord }}
PID=$(hyprctl clients -j | jq -r '.[] | select(.class == "discord") | .pid')
kill -9 $PID
discord
{{ /if }}
# Not necessary if you have `dotter watch` in the background
dotter deploy -g $DOTTER_CONF --force

notify-send "Theme Switcher" "Changing Theme to $THEME"
notify-send "Dotter" "Deployed Changes"
