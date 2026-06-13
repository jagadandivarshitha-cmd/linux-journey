#!/bin/bash

SOURCE_DIR="$HOME/worldbanc"
BACKUP_DIR="$HOME/backups"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="backup_$DATE.tar.gz"
RETENTION_DAYS=7

mkdir -p "$BACKUP_DIR"

tar -czf "$BACKUP_DIR/$BACKUP_NAME" -C "$HOME" worldbanc

echo "Backup Created : $BACKUP_NAME"

find "$BACKUP_DIR" -name "backup_*.tar.gz" -mtime +$RETENTION_DAYS -delete

echo "Old backups (older than $RETENTION_DAYS days) removed"

echo "----------------------------------------"
echo "Backup completed at $(date)"
echo "Backup location: $BACKUP_DIR/$BACKUP_NAME"
echo "Current backups:"
ls -lh "$BACKUP_DIR"
