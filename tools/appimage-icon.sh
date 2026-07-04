#!/bin/bash

FILENAME=$1
if [ -z "$1" ]; then
  echo "No file provided."
  exit 1
fi
if [[ "$FILENAME" != *.AppImage ]]; then
  echo "Not an AppImage."
  exit 1
fi

OUTPUT=${2:-$PWD}

mkdir -p "$OUTPUT" && echo "Created OUTPUT: $OUTPUT"

chmod +x "$FILENAME"
"$FILENAME" --appimage-extract >/dev/null

if [ ! -f "squashfs-root/.DirIcon" ]; then
  echo "No icon found."
  exit 1
fi
cp "squashfs-root/.DirIcon" "$OUTPUT/$(basename "$FILENAME" .AppImage).png" && echo "Extracted icon."
rm -rf squashfs-root


