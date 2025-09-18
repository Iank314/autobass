#!/bin/bash

LOGFILE="archive.log"

log() {
  LEVEL=$1
  MESSAGE=$2
  TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
  echo "$LEVEL: [$TIMESTAMP] $MESSAGE" | tee -a "$LOGFILE"
}


log "INFO" "archive script started."

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  echo "Usage: $0 <source_dir> <target_dir>"
  echo "Creates a timestamped backup of source_dir inside target_dir."
  exit 0
fi

SOURCE=$1
TARGET=$2

if [[ -z "$SOURCE" || -z "$TARGET" ]]; then
  log "ERROR" "Missing arguments. Usage: $0 <source_dir> <target_dir>"
  exit 1
fi

if [[ ! -d "$SOURCE" || ! -r "$SOURCE" ]]; then
  log "ERROR" "Source directory ($SOURCE) does not exist or is not readable. Exiting."
  exit 1
fi

if [[ ! -d "$TARGET" ]]; then
  if ! mkdir -p "$TARGET"; then
    log "ERROR" "Target directory ($TARGET) does not exist or could not be created. Exiting."
    exit 1
  fi
fi

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_FILE="$TARGET/backup_$TIMESTAMP.tar.gz"

log "INFO" "Backing up from $SOURCE to $ARCHIVE_FILE."

if tar -czf "$ARCHIVE_FILE" -C "$SOURCE" .; then
  log "INFO" "Backup completed successfully."
else
  log "ERROR" "Backup failed during compression."
  exit 1
fi

# Placeholder for unexpected errors
# Example usage:
# log "ERROR" "<placeholder>"