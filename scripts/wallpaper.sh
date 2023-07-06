#!/bin/bash
#

NAME=${$1%.mp4}
ffmpeg -ss 0 -i "$1" \
    -vf "fps=60,scale=2560:1440:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
    -loop 0 $2
