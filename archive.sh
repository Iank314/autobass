#!/bin/bash

log "INFO" "archive script started."

LOGFILE="archive.log"

log() {
  LEVEL=$1
  MESSAGE=$2
  TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
  echo "$LEVEL: [$TIMESTAMP] $MESSAGE" | tee -a "$LOGFILE"
}

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


ARCHIVE_FILE="$TARGET/backup_$TIMESTAMP.tar.gz"

if tar -czf "$ARCHIVE_FILE" -C "$SOURCE" .; then
  echo "Backup completed: $ARCHIVE_FILE"
else
  echo "Error: Backup failed during compression."
  exit 1
fi