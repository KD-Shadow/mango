#!/bin/bash

art_dir="$HOME/.config/fastfetch/logo/"

random_art=$(find "$art_dir" -type f \( -iname "*.txt" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.jpg" -o -iname "*.icon" \) | shuf -n 1)

ext="${random_art##*.}"

if [[ "$ext" == "txt" ]]; then
  fastfetch --logo-type file --logo "$random_art"
else
  fastfetch --logo-type kitty --logo "$random_art"
fi
