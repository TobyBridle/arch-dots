#!/bin/env sh

DOTTER_CONF="/home/tobybridle/dotfiles/.dotter/global.toml"
# If you are that stupid that you have a "" in your colorschemes, uncomment the below
#THEME=$(/bin/cat $DOTTER_CONF | tomlq -c .global.variables.theming | sed -E 's/\{"colorschemes":\W?\[(".+"\W?|".+",\W?)*\]\}/\1/' | tr ',' '\n' | cut -d '"' -f2 | grep "\S" | rofi -dmenu)
THEME=$(/bin/cat $DOTTER_CONF | tomlq -c .global.variables.theming | sed -E 's/\{"colorschemes":\W?\[(".+"\W?|".+",\W?)*\]\}/\1/' | tr ',' '\n' | cut -d '"' -f2 | rofi -dmenu)

if [ -z "$THEME"]; then
    notify-send "Theme Switcher" "Aborting. Changes not saved."
    return
fi

notify-send "Theme Switcher" "Changing Theme to $THEME"
/bin/cat <<EOM >$DOTTER_CONF
$(/bin/cat $DOTTER_CONF | tomlq ".colorscheme.depends=[\"$THEME\"]" | yj -jt)
EOM
# Not necessary if you have `dotter watch` in the background
dotter deploy -g $DOTTER_CONF
notify-send "Dotter" "Deployed Changes"
