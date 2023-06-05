FROM debian

# Install mysql-client and other dependencies
RUN apt-get update && apt-get install -y default-mysql-client cron

# Create the backup directory
RUN mkdir /backups

# Copy the backup script
COPY backup.sh /backup.sh
COPY startup.sh /startup.sh

# Set execute permissions for the scripts
RUN chmod +x /backup.sh
RUN chmod +x /startup.sh

# Set the default cron schedule pattern -> run every two hours
ENV CRON_SCHEDULE_PATTERN="0 */2 * * *"

# Write logs to external database -> do not write by default
ENV WRITE_LOGS=0


# run the startup script
ENTRYPOINT ["bash", "/startup.sh"]