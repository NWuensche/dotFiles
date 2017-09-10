if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi
export PATH=$PATH":$HOME/bin"

#nitrogen --set-centered "$(dirname $(dirname $(realpath $(which nitrogen))))/wallpaper.jpg"

