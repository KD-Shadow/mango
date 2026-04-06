#!/usr/bin/env bash

SETTINGS="$HOME/.config/noctalia-shell/settings.json"

STATIC_THEMES=(
  "Catppuccin"
  "Kanagawa"
  "Lilac AMOLED"
  "Rosey AMOLED"
  "Osaka jade"
  "Rose Pine"
  "Monochrome"
  "Tokyo Night"
  "Nord"
)

MATUGEN_SCHEMES=(
  "tonal-spot"
  "content"
  "fruit-salad"
  "rainbow"
  "monochrome"
  "vibrant"
  "faithful"
  "dysfunctional"
  "muted"
)

THEME_LIST="󰔎 dynamic (wallpaper-based)"
for theme in "${STATIC_THEMES[@]}"; do
  THEME_LIST+="\n$theme"
done

SELECTED=$(echo -e "$THEME_LIST" | rofi -dmenu -p "󰔎 Theme" -i -theme /home/sh4dow/.config/rofi/style_3.rasi)
[[ -z "$SELECTED" ]] && exit 0

TMP=$(mktemp)

if [[ "$SELECTED" == *"dynamic"* ]]; then
  SCHEME_LIST=$(printf "%s\n" "${MATUGEN_SCHEMES[@]}")
  SELECTED_SCHEME=$(echo "$SCHEME_LIST" | rofi -dmenu -p "󱓻 Matugen Scheme" \
    -i -theme /home/sh4dow/.config/rofi/style_3.rasi)
  [[ -z "$SELECTED_SCHEME" ]] && exit 0

  jq '.colorSchemes.useWallpaperColors = true' "$SETTINGS" >"$TMP" && mv "$TMP" "$SETTINGS"
  qs -c noctalia-shell ipc call colorScheme setGenerationMethod "$SELECTED_SCHEME"
  qs -c noctalia-shell ipc call wallpaper refresh
else
  jq '.colorSchemes.useWallpaperColors = false' "$SETTINGS" >"$TMP" && mv "$TMP" "$SETTINGS"
  qs -c noctalia-shell ipc call colorScheme set "$SELECTED"
fi
