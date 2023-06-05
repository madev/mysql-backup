# mysql-backup
Backups mysql database using mysql dump.

## Crontab
- backups are being done by crontab, which runs backup.sh script in set interval
- with each backup the size and duration of the backup are being logged
    - these logs are optionally saved to the database as well
    - log database shoud be named 'logs'
        - there should be one table named 'backup_logs' with 3 columns(duration, backup_size, backup_name)

## Env variables
DB_HOST -> database host, either domain name or IP address
DB_PORT -> database port
DB_USERNAME -> database username
DB_PASSWORD -> database password
DB_NAME -> name of the database which should be backed up
CRON_SCHEDULE_PATTERN -> pattern for cron which specifies how often should be the backups done (default value set to '0 */2 * * *')
WRITE_LOGS -> whether to write logs to log database (default value set to 0)