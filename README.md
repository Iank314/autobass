autobass

autobass is a Bash-based backup automation script designed to simplify file management. It creates timestamped compressed archives of your files and supports configuration through a dedicated config file. The tool allows exclusions using a .bassignore file and provides a dry-run mode to simulate backups. With logging, autobass makes sure backups are reliable, repeatable, and easy to track.

📑 Table of Contents

About the Project

Built With

Getting Started

Prerequisites

Installation

Usage

Configuration

Logging

Features

Roadmap

📖 About the Project

autobass helps you automate backups in a clean and repeatable way. Instead of manually compressing and moving files, you can run a single script to generate timestamped .tar.gz archives.

It’s flexible:

Configure default source/target directories in archive.conf

Exclude unwanted files and folders with .bassignore

Run in dry-run mode to preview backups without actually creating archives

Keep track of everything with detailed logs

🛠 Built With

Bash (pure shell scripting)

tar and gzip (for compressed backups)

⚡ Getting Started
Prerequisites

A Linux or Linux-like environment (macOS, WSL, etc.)

Bash shell

tar and gzip installed

Installation

Clone the repo:

git clone https://github.com/Iank314/autobass.git


Enter the project directory:

cd autobass


Make the script executable:

chmod +x archive.sh

▶️ Usage
Run with arguments
./archive.sh <source_dir> <target_dir>

Run with config defaults

Set defaults in archive.conf:

SOURCE_DIR=/home/user/source
TARGET_DIR=/home/user/target


Run without arguments:

./archive.sh

Dry-run (simulation)
./archive.sh -d <source_dir> <target_dir>

Show help
./archive.sh -h

⚙️ Configuration
Config file (archive.conf)

Defines default source and target directories. Example:

SOURCE_DIR=/home/iank/test_source
TARGET_DIR=/home/iank/test_target

Exclusion file (.bassignore)

Defines patterns of files and folders to skip during backup. Example:

*.log
*.tmp
tmp/
*.cache

📝 Logging

All operations are logged with timestamps in archive.log.
Logs are written to both the console and the log file, making it easy to debug or review backups later.

🌟 Features

✅ Timestamped compressed backups (.tar.gz)

✅ Configurable defaults via archive.conf

✅ Exclusions with .bassignore

✅ Dry-run simulation

✅ Detailed logging to console and archive.log

Features included in MVP: backup, compression, logging, config support, exclusions, and dry-run.

📌 Roadmap

 Add email notifications for completed backups

 Add support for incremental backups

 Add restore functionality
