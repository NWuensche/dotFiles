#!/bin/sh
set -e
FOLDER=$HOME/Bilder
mkdir -p $FOLDER
grim -g "$(slurp)" "$FOLDER/`date +'%Y.%m.%d %H-%M-%S'`.png"
