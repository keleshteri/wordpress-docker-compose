# restore.sh - Database restore script

#!/bin/bash
# restore.sh - Database restore script

# Configuration
CONTAINER_NAME="wp_db"
DB_NAME="wordpress"
DB_USER="wordpress"
DB_PASSWORD="wordpress_password"
BACKUP_DIR="./backups"

# Check if backup file is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <backup_file.sql.gz>"
    echo "Available backups:"
    ls -la $BACKUP_DIR/*.sql.gz 2>/dev/null || echo "No backups found"
    exit 1
fi

BACKUP_FILE=$1

# Check if backup file exists
if [ ! -f "$BACKUP_DIR/$BACKUP_FILE" ]; then
    echo "Backup file not found: $BACKUP_DIR/$BACKUP_FILE"
    exit 1
fi

# Extract backup if it's compressed
if [[ $BACKUP_FILE == *.gz ]]; then
    echo "Extracting compressed backup..."
    gunzip -c $BACKUP_DIR/$BACKUP_FILE > /tmp/restore_temp.sql
    RESTORE_FILE="/tmp/restore_temp.sql"
else
    RESTORE_FILE="$BACKUP_DIR/$BACKUP_FILE"
fi

# Restore database
echo "Restoring database from $BACKUP_FILE..."
docker exec -i $CONTAINER_NAME mysql -u$DB_USER -p$DB_PASSWORD $DB_NAME < $RESTORE_FILE

# Clean up temporary file
if [ -f "/tmp/restore_temp.sql" ]; then
    rm /tmp/restore_temp.sql
fi

echo "Database restore completed!"