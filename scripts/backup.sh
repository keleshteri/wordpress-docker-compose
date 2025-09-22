#!/bin/bash
# backup.sh - Database backup script

# Configuration
CONTAINER_NAME="wp_db"
DB_NAME="wordpress"
DB_USER="wordpress"
DB_PASSWORD="wordpress_password"
BACKUP_DIR="./backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="wordpress_backup_$TIMESTAMP.sql"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Create database backup
echo "Creating database backup..."
docker exec $CONTAINER_NAME mysqldump -u$DB_USER -p$DB_PASSWORD $DB_NAME > $BACKUP_DIR/$BACKUP_FILE

# Compress the backup
gzip $BACKUP_DIR/$BACKUP_FILE

echo "Backup completed: $BACKUP_DIR/$BACKUP_FILE.gz"

# Keep only last 10 backups
ls -t $BACKUP_DIR/*.sql.gz | tail -n +11 | xargs -r rm