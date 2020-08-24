#!/bin/bash
sudo touch /etc/fail2ban/jail.d/sshd.local
echo -e "[sshd]\nenabled	= true\nport	= 50486\nfilter	= sshd\nbanaction	= ufw\nbackend	= systemd\nmaxretry	= 5\nbantime	= 600" >>/etc/fail2ban/jail.d/sshd.local
systemctl start fail2ban
echo "Set fail2ban jail for ssh."
