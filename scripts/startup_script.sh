#!/bin/sh

# Start MPD
[ -f "$(which mpd)" ] && systemctl --user start mpd.service

# Start mpDris2 (if it exists)
[ -f "$(which mpDris2)" ] && systemctl --user start mpDris2.service
