#!/usr/bin/env bash

PDF_DIR="$HOME/Documents/pdfs"
ROFI_THEME="$HOME/.config/rofi/style_4.rasi"
VIEWER="zathura"

# Create the PDF directory if it doesn't exist
mkdir -p "$PDF_DIR"

# Move any PDFs found in home (non-recursively, top-level only) to PDF_DIR
# If you want to sweep a specific folder instead, adjust the find path below
find "$HOME" -maxdepth 1 -name "*.pdf" ! -path "$PDF_DIR/*" -exec mv -n {} "$PDF_DIR/" \;

# List PDFs in the dedicated folder
mapfile -t pdf_files < <(find "$PDF_DIR" -name "*.pdf" | sort)

if [[ ${#pdf_files[@]} -eq 0 ]]; then
  notify-send "PDF Opener" "No PDFs found in $PDF_DIR"
  exit 1
fi

# Build display names (basename only) while keeping full paths
display_names=()
for f in "${pdf_files[@]}"; do
  display_names+=("$(basename "$f")")
done

# Show rofi picker
selected=$(printf '%s\n' "${display_names[@]}" |
  rofi -dmenu -p "Open PDF" -theme "$ROFI_THEME")

[[ -z "$selected" ]] && exit 0

# Match selected name back to full path
for f in "${pdf_files[@]}"; do
  if [[ "$(basename "$f")" == "$selected" ]]; then
    "$VIEWER" "$f" &
    exit 0
  fi
done
