#!/bin/sh
set -e
FOLDER=$HOME/Bilder
mkdir -p $FOLDER
scrot "$FOLDER/%Y.%m.%d %H-%M-%S.png" 

