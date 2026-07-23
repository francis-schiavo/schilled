#!/bin/bash

# Checks the required environment variables
if ! test -n "$WORKSHOP_DIR"; then
  echo "WORKSHOP_DIR is not set"
  exit 1
fi

if ! test -n "$BUILD"; then
  BUILD="41"
fi

# Cleanup the previous build
rm -rf "$WORKSHOP_DIR/Schilled"
mkdir "$WORKSHOP_DIR/Schilled"

# Copy the files to the build directory
if [ "$BUILD" == "41" ]; then
  echo "Building for 41"
  for mod_dir in ./Contents/mods/*/; do
    mod_name=$(basename "$mod_dir")
    if [ -d "$mod_dir/41" ]; then
      mkdir -p "$WORKSHOP_DIR/Schilled/Contents/mods/$mod_name"
      cp -r "$mod_dir/41/"* "$WORKSHOP_DIR/Schilled/Contents/mods/$mod_name/"
    fi
    if [ -d "$mod_dir/common" ]; then
      mkdir -p "$WORKSHOP_DIR/Schilled/Contents/mods/$mod_name"
      cp -r "$mod_dir/common/"* "$WORKSHOP_DIR/Schilled/Contents/mods/$mod_name/"
    fi
  done
else
  echo "Building for $BUILD"
  cp -r ./Contents "$WORKSHOP_DIR/Schilled/"
fi

cp -r ./preview.png "$WORKSHOP_DIR/Schilled/"
cp -r ./workshop.txt "$WORKSHOP_DIR/Schilled/"
