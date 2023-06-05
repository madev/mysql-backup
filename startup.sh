#!/bin/bash

echo "$CRON_SCHEDULE_PATTERN . /backup.sh >> /var/log/cron.log 2>&1" >> /etc/cron.d/backupjob

# clean the variable, because the spaces make trouble in next command
export CRON_SCHEDULE_PATTERN=""
env > env_vars

crontab /etc/cron.d/backupjob
touch /var/log/cron.log
cron && tail -f /var/log/cron.log