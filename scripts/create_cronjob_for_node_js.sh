#!/bin/bash
rm /etc/cron.d/start-node-js-server
touch /etc/cron.d/start-node-js-server
echo '@reboot	root	sudo node /home/kafkan223/hiddengames/server.js&' >>/etc/cron.d/start-node-js-server
echo "Set Node.js server to start up at reboot."
