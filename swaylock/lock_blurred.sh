#!/bin/bash

# Lock the screen with a blurred version of the current screen
grim ~/.local/share/lockscreen.png
magick convert ~/.local/share/lockscreen.png -blur 0x8 ~/.local/share/lockscreen.png
swaylock
