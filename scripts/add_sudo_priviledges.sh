#!/bin/bash
echo "Adding sudo priviledges to $USER"
touch /etc/sudoers.d/$USER
echo "$USER	ALL=(ALL:ALL) ALL" >>/etc/sudoers.d/$USER
chmod 440 /etc/sudoers.d/$USER
