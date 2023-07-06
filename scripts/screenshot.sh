case "$1" in
  fullscreen) grim - | wl-copy ; notify-send "Screenshot Copied"
  ;;
  select-area) grim -g "$(slurp)" - | wl-copy ; notify-send "Screenshot Copied"
  ;;
esac
