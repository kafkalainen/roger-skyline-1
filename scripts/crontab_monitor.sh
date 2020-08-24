#!/bin/bash
LOGFILE=/var/log/update_crontab.log
if [ -f $LOGFILE ];
then
        echo "exists"
else
        touch /var/log/update_crontab.log
fi
DIFF=$(diff <(sha256sum /etc/crontab) /var/log/update_crontab.log)
if [ -n "$DIFF" ];
then
        mail -s "Crontab changed" root@localhost <<<$(echo "There has been a change in crontab file. $DIFF $(cat /etc/crontab)")
        sha256sum /etc/crontab >/var/log/update_crontab.log
else
        echo "There has been no change in crontab file."
fi
