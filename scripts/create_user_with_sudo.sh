#!/bin/bash
adduser $1
echo "Adding sudo priviledges to $1"
touch /etc/sudoers.d/$1
echo "$1 ALL=(ALL:ALL) ALL" >>/etc/sudoers.d/$1
chmod 440 /etc/sudoers.d/$1
mkdir /home/$1/.ssh 
touch /home/$1/.ssh/authorized_keys
chown -R $1:$1 /home/$1/.ssh
chmod 600 /home/$1/.ssh/authorized_keys
echo "AllowUsers $1" >>/etc/ssh/sshd_config
sudo service ssh restart
echo "Access to the computer by using the account already, and copy pubkey to the authorized keys."
