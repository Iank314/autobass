#This is my autobass assignment

Project Description
autobass is a Bash-based backup automation script designed to simplify file management.
It creates timestamped compressed archives of your files and supports configuration through a dedicated config file.
The tool allows exclusions using a .bassignore file and provides a dry-run mode to simulate backups.
With detailed logging, autobass makes sure backups are reliable, repeatable, and easy to track.

Installation

Clone the repository:
git clone https://github.com/Iank314/autobass.git

cd autobass

Make the script executable:
chmod +x archive.sh

Usage
Run with arguments

Provide a source directory and target directory:
./archive.sh <source_dir> <target_dir>

Run with config defaults

Set defaults in archive.conf:
SOURCE_DIR=/home/user/source
TARGET_DIR=/home/user/target

Run without arguments:
./archive.sh

Dry-run (simulation)

See what would be backed up without creating an archive:
./archive.sh -d <source_dir> <target_dir>

Show help

Display usage instructions:
./archive.sh -h

Configuration
Config file (archive.conf)

Defines default source and target directories. I used:
SOURCE_DIR=/home/iank/test_source
TARGET_DIR=/home/iank/test_target

Exclusion file (.bassignore)

Defines patterns of files and folders to skip during backup. I used:
*.log
*.tmp
tmp/
*.cache

Logging
All operations are logged with timestamps in archive.log.

Features:

Timestamped compressed backups (.tar.gz)

Configurable defaults with archive.conf

Exclusions with .bassignore

Dry-run simulation

Detailed logging to console and archive.log


Features included: MVP backup, compression, logging, config support, exclusions, and dry-run
