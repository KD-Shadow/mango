#!/usr/bin/env bash
THEMES_DIR="$HOME/.config/DankMaterialShell/themes"
SETTINGS="$HOME/.config/DankMaterialShell/settings.json"

MATUGEN_SCHEMES=(
  "scheme-content"
  "scheme-expressive"
  "scheme-fidelity"
  "scheme-fruit-salad"
  "scheme-monochrome"
  "scheme-neutral"
  "scheme-rainbow"
  "scheme-tonal-spot"
)

# Build list: "dynamic" first, then all theme folders
THEME_LIST="󰔎 dynamic (wallpaper-based)\n"
while IFS= read -r dir; do
  THEME_LIST+="$(basename "$dir")\n"
done < <(ls -d "$THEMES_DIR"/*/)

SELECTED=$(echo -e "$THEME_LIST" | rofi -dmenu -p "󰔎 Theme" -i -theme /home/sh4dow/.config/rofi/style_3.rasi)
[[ -z "$SELECTED" ]] && exit 0

TMP=$(mktemp)

if [[ "$SELECTED" == *"dynamic"* ]]; then
  # Ask for matugen scheme
  SCHEME_LIST=$(printf "%s\n" "${MATUGEN_SCHEMES[@]}")
  CURRENT_SCHEME=$(jq -r '.matugenScheme' "$SETTINGS")

  SELECTED_SCHEME=$(echo "$SCHEME_LIST" | rofi -dmenu -p "󱓻 Matugen Scheme" \
    -i -theme /home/sh4dow/.config/rofi/style_3.rasi \
    -select "$CURRENT_SCHEME")

  # Default to current scheme if nothing selected
  [[ -z "$SELECTED_SCHEME" ]] && SELECTED_SCHEME="$CURRENT_SCHEME"

  jq --arg scheme "$SELECTED_SCHEME" \
    '.currentThemeName = "dynamic" | .currentThemeCategory = "dynamic" | .matugenScheme = $scheme' \
    "$SETTINGS" >"$TMP" && mv "$TMP" "$SETTINGS"

  notify-send "󰔎 Theme" "Dynamic — $SELECTED_SCHEME"
else
  THEME_FILE="$THEMES_DIR/$SELECTED/theme.json"
  [[ ! -f "$THEME_FILE" ]] && notify-send "DankShell" "theme.json not found for $SELECTED" && exit 1

  jq --arg name "$SELECTED" \
    --arg path "$THEME_FILE" \
    '.currentThemeName = "custom" | .currentThemeCategory = "registry" | .customThemeFile = $path' \
    "$SETTINGS" >"$TMP" && mv "$TMP" "$SETTINGS"

  notify-send "󰔎 Theme" "Switched to $SELECTED"
fi
