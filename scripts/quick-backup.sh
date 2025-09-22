# quick-backup.sh - Quick backup with WP-CLI

#!/bin/bash
# quick-backup.sh - Complete WordPress backup (files + database)

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="./backups"
BACKUP_NAME="wp_complete_backup_$TIMESTAMP"

mkdir -p $BACKUP_DIR/$BACKUP_NAME

# Backup database using WP-CLI
echo "Backing up database with WP-CLI..."
docker run --rm --volumes-from wp_site --network wordpress-docker-compose_wordpress-network \
    wordpress:cli db export /backups/$BACKUP_NAME/database.sql

# Backup WordPress files
echo "Backing up WordPress files..."
cp -r ./wordpress $BACKUP_DIR/$BACKUP_NAME/
cp -r ./uploads $BACKUP_DIR/$BACKUP_NAME/ 2>/dev/null || true
cp -r ./themes $BACKUP_DIR/$BACKUP_NAME/ 2>/dev/null || true
cp -r ./plugins $BACKUP_DIR/$BACKUP_NAME/ 2>/dev/null || true

# Create compressed archive
echo "Creating compressed archive..."
cd $BACKUP_DIR
tar -czf $BACKUP_NAME.tar.gz $BACKUP_NAME
rm -rf $BACKUP_NAME

echo "Complete backup created: $BACKUP_DIR/$BACKUP_NAME.tar.gz"