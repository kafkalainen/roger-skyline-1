#!/bin/bash
rm /etc/cron.d/update-system-packages
touch /etc/cron.d/update-system-packages
echo '0 4 * * 1 root	sudo /usr/local/bin/run_update_packages.sh' >>/etc/cron.d/update-system-packages
echo '@reboot	root	sudo /usr/local/bin/run_update_packages.sh' >>/etc/cron.d/update-system-packages
