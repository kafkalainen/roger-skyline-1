#!/bin/bash
sudo /etc/init.d/portsentry stop
sed -i 's/TCP_MODE=\"tcp\"/TCP_MODE=\"atcp\"/' /etc/default/portsentry
sed -i 's/UDP_MODE=\"udp\"/UDP_MODE=\"audp\"/' /etc/default/portsentry
sed -i 's/BLOCK_UDP=\"0\"/BLOCK_UDP=\"1\"/' /etc/portsentry/portsentry.conf
sed -i 's/BLOCK_TCP=\"0\"/BLOCK_TCP=\"1\"/' /etc/portsentry/portsentry.conf
sed -i 's/KILL_ROUTE=\"\/sbin\/route add -host $TARGET$ reject\"/#KILL_ROUTE=\"\/sbin\/route add -host $TARGET$ reject\"/' /etc/portsentry/portsentry.conf
sed -i 's/#KILL_ROUTE=\"\/sbin\/iptables -I INPUT -s $TARGET$ -j DROP\"/KILL_ROUTE=\"\/sbin\/iptables -I INPUT -s $TARGET$ -j DROP\"/' /etc/portsentry/portsentry.conf
sudo /etc/init.d/portsentry start
