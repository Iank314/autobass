#!/bin/bash

LOGFILE="archive.log"

log() {
  LEVEL=$1
  MESSAGE=$2
  TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
  echo "$LEVEL: [$TIMESTAMP] $MESSAGE" | tee -a "$LOGFILE"
}


log "INFO" "archive script started."

if [[ -f archive.conf ]]; then
  source archive.conf
fi

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  echo "Usage: $0 <source_dir> <target_dir>"
  echo "Creates a timestamped backup of source_dir inside target_dir."
  exit 0
fi

DRYRUN=""
if [[ "$1" == "-d" || "$1" == "--dry-run" ]]; then
  DRYRUN="--dry-run"
  log "INFO" "Dry-run enabled. Simulating backup."
  shift
fi


SOURCE=$1
TARGET=$2

if [[ -z "$SOURCE" || -z "$TARGET" ]]; then
  if [[ -n "$SOURCE_DIR" && -n "$TARGET_DIR" ]]; then
    SOURCE=$SOURCE_DIR
    TARGET=$TARGET_DIR
  else
    log "ERROR" "Missing arguments and no config defaults set. Usage: $0 <source_dir> <target_dir>"
    exit 1
  fi
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

EXCLUDES=""
if [[ -f .bassignore ]]; then
  while IFS= read -r pattern; do
    [[ -n "$pattern" ]] && EXCLUDES+=" --exclude=$pattern"
  done < .bassignore
fi

log "INFO" "Backing up from $SOURCE to $ARCHIVE_FILE."

if [[ -n "$DRYRUN" ]]; then
  log "INFO" "Dry-run listing of files to be backed up:"
  tar -tzf <(tar -czf - $EXCLUDES -C "$SOURCE" .) 2>/dev/null
  log "INFO" "Dry-run completed. No archive was created."
else
  if tar $EXCLUDES -czf "$ARCHIVE_FILE" -C "$SOURCE" .; then
    log "INFO" "Backup completed successfully."
  else
    log "ERROR" "Backup failed during compression."
    exit 1
  fi
fi
