#!/bin/bash
rm /etc/cron.d/check-for-crontab-changes
touch /etc/cron.d/check-for-crontab-changes
echo '0 0	* * *	root	sudo /usr/local/bin/crontab_monitor.sh' >>/etc/cron.d/check-for-crontab-changes
echo "Set a monitor for crontab for changes."
