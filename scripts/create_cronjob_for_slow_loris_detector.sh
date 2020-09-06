#!/bin/bash
rm /etc/cron.d/slow_loris_detector
touch /etc/cron.d/slow_loris_detector
echo "@reboot	root	sudo /usr/local/bin/slow_loris.sh&" >>/etc/cron.d/slow_loris_detector
echo "Set Slowloris detector at reboot."
