#!/bin/bash

# Checks the required environment variables
if ! test -n "$WORKSHOP_DIR"; then
  echo "WORKSHOP_DIR is not set"
  exit 1
fi

# Cleanup the previous build
rm -rf "$WORKSHOP_DIR/schilled"
mkdir "$WORKSHOP_DIR/schilled"

# Copy the files to the build directory
cp -r ./Contents "$WORKSHOP_DIR/schilled/"
cp -r ./preview.png "$WORKSHOP_DIR/schilled/"
cp -r ./workshop.txt "$WORKSHOP_DIR/schilled/"
