#!/bin/bash
sudo touch /etc/fail2ban/jail.d/sshd.local
echo -e "[sshd]\nenabled	= true\nport	= 50486\nfilter	= sshd\nbanaction	= ufw\nbackend	= systemd\nmaxretry	= 5\nbantime	= 600\nignoreip	= 192.168.56.1" >>/etc/fail2ban/jail.d/sshd.local
systemctl start fail2ban
