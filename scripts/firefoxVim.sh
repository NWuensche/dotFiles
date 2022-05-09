#!/bin/sh
set -e

# When using `gx` in vim to open URL, don't block vim when no browser was opened before

firefox "$@" &
