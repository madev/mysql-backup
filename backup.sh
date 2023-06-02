#!/bin/bash
. /env_vars

echo "Running backup at $(date "+%Y-%m-%d-%H:%M")"
backup_name="$(date "+%Y-%m-%d-%H:%M").sql"
start_time=$(date +%s)

mysqldump -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USERNAME" --password="$DB_PASSWORD" "$DB_NAME" > "/backups/$backup_name"

end_time=$(date +%s)
backup_size=$(du --human-readable "/backups/$backup_name" | awk '{print $1}')
duration=$((end_time - start_time))
duration=$(date -u -d @$duration +'%H:%M:%S')

mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USERNAME" --password="$DB_PASSWORD" -e "USE logs;INSERT INTO backup_logs (duration, size, name) VALUES ('$duration', '$backup_size', '$backup_name');"

echo "Backup completed"
echo "Duration: $(date -u -d @$duration +'%H:%M:%S')"
echo "Backup Size: $backup_size"
echo "-------------------------------"