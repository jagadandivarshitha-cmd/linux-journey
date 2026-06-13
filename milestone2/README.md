# Automated Backup Script

A bash script that creates compressed backups with automatic cleanup.

## What it does
- Backs up a folder into a timestamped .tar.gz archive
- Stores backups in ~/backups/
- Automatically deletes backups older than 7 days
- Can be scheduled with cron for daily automation

## How to run
chmod +x backup.sh
./backup.sh

## Schedule daily at 2 AM (cron)
0 2 * * * /home/varshitha/linux-journey/milestone2/backup.sh

## Built by
Varshitha — Linux Journey Day 10
