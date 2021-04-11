#!/bin/bash
set -e

apt-get install -y zenity

# Randomly generated uuidv4 to make sure its our job.
JOB_UUID="7c0fe164-9162-40dd-86b4-d8e804735aac"

CRON_USER=$SUDO_USER
CRON_WRAPPER="/home/${CRON_USER}/.dotfiles/bin/desktop-cron-wrapper"

CRON_TIME="08 * * * * "

COMMAND="bash -l -c '$CRON_WRAPPER /home/${CRON_USER}/.config/backups/backup-check.sh'"

CRON_LINE="$CRON_TIME $COMMAND # job uuid: ${JOB_UUID}"

TMP_FILE=$(mktemp)
# We remove our cron line and install it again every time, to update any change we may do on the cron line.
(crontab -u $CRON_USER -l || true) | grep -v $JOB_UUID > $TMP_FILE || true

echo "Setting backups cron job"
echo "$CRON_LINE" >> $TMP_FILE
crontab -u $CRON_USER $TMP_FILE

rm $TMP_FILE
