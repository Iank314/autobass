#!/bin/bash

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  echo "Usage: $0 <source_dir> <target_dir>"
  echo "Creates a timestamped backup of source_dir inside target_dir."
  exit 0
fi

SOURCE=$1
TARGET=$2

if [[ -z "$SOURCE" || -z "$TARGET" ]]; then
  echo "Error: Missing arguments."
  echo "Usage: $0 <source_dir> <target_dir>"
  exit 1
fi

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="$TARGET/backup_$TIMESTAMP"

mkdir -p "$BACKUP_DIR"

if cp -r "$SOURCE"/* "$BACKUP_DIR"; then
  echo "Backup completed: $BACKUP_DIR"
else
  echo "Error: Copy failed."
  exit 1
fi