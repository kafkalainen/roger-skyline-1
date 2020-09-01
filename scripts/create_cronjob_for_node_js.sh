#!/bin/bash
rm /etc/cron.d/start-node-js-server
touch /etc/cron.d/start-node-js-server
echo "@reboot	root	sudo node /var/www/hiddengames/server.js&" >>/etc/cron.d/start-node-js-server
echo "Set Node.js server to start up at reboot."
