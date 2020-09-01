#!/bin/bash
for file in /etc/netplan/*.yaml; do mv "$file" "${file%.yaml}.backup"; done
touch /etc/netplan/00-static-ip-config.yaml
echo "network:">>/etc/netplan/00-static-ip-config.yaml
echo "  ethernets:">>/etc/netplan/00-static-ip-config.yaml
echo "    enp0s3:">>/etc/netplan/00-static-ip-config.yaml
echo "      dhcp4: true">>/etc/netplan/00-static-ip-config.yaml
echo "    enp0s8:">>/etc/netplan/00-static-ip-config.yaml
echo "      addresses:">>/etc/netplan/00-static-ip-config.yaml
echo "      - 192.168.42.2/30">>/etc/netplan/00-static-ip-config.yaml
echo "      nameservers:">>/etc/netplan/00-static-ip-config.yaml
echo "        addresses:">>/etc/netplan/00-static-ip-config.yaml
echo "        - 1.1.1.1">>/etc/netplan/00-static-ip-config.yaml
echo "        - 1.0.0.1">>/etc/netplan/00-static-ip-config.yaml
echo "  version: 2">>/etc/netplan/00-static-ip-config.yaml
sudo netplan apply
sleep 2s
CURRENT_IP=$(ip addr show | grep "enp0s8" | grep "inet" | awk '{ print $2 }')
if [[ $CURRENT_IP == "192.168.42.2/30" ]]
then
	echo "Static IP successfully set."
else
	echo "Static IP failed: $CURRENT_IP"
fi
