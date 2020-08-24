#Roger-Skyline-1
##VM-part
[x] Distro and VM
I did some online research what distribution to choose, and had a contest between Ubuntu Server 20.04 distribution and Debian Linux as minimum installation. Static IP connection proved to be somewhat a hassle to do on Debian as /30 was not working on my home desktop with bridged adapter. At the same time, I was configuring Ubuntu 20.04 to work with NAT and Host-Only Adapter, and that network configuration finally beared a fruit. I downloaded Ubuntu Server from here:
[Download link](https://ubuntu.com/download/server)
I also chose Oracle VM's VirtualBox to create the virtual network. For the virtual network interfaces I chose NAT and Host-Only adapter, with vbox0 network with static ip address and subnet mask:
	ipv4	192.168.56.1
	subnet	255.255.255.252
[x] A disk size 8 GB
In installer I chose to create 8 GB static VDI.
[x] Have at least one 4.2 Gb partition
During the installation I chose to create partition of 4.2GB for / and mount the rest for /home as a logical partition.
[x] It will also have to be up to date as well as the whole packages installed to meet the demands of this subject.
- When the installation was complete, I updated the system with:
	sudo apt-get update -y && sudo apt-get upgrade
#Network and Security
[x] You must create a non-root user to connect to the machine and work.
- During the installation I created kafkan223 as a non-root user.
[x] Use sudo, with this user, to be able to perform operation requiring special rights.
- Ubuntu 20.04 comes preinstalled with sudo, and created user kafkan223 
was given sudo priviledges. Root user in general is locked in Ubuntu.
- To add user to usergroup sudoers, I use following command:
	sudo usermod -aG sudo kafkan223
- If I want to achieve giving sudo priviledges by shell script, I would do:
	touch add_sudo_user.sh

	#!/bin/bash
	touch /etc/sudoers.d/$USER
	echo "$USER	ALL=(ALL:ALL) ALL" >>/etc/sudoers.d/$USER
	chmod 440 etc/sudoers.d/$USER
- This adds currently logged in user to the sudoers. To run such a shell script,
you need to pass the current env variables. 
	sudo --preserve-env=USER /usr/bin/env ./add_sudo_priviledges.sh 
[x] We don’t want you to use the DHCP service of your machine.  You’ve got to configure it to have a static IP and a Netmask in \30.
- I also configured static ip during the installation. On my first try, I first had dhcp4 automatically set my ip address to fetch packages and edited /etc/netplan/\*.yaml file accordingly.
	touch configure_netplan.sh
	chmod 755 configure_netplan.sh

	#!/bin/bash
	mv /etc/netplan/*.yaml /etc/netplan/*.yaml.backup
	touch /etc/netplan/00-static-ip-config.yaml
	echo "network:">>/etc/netplan/00-static-ip-config.yaml
	echo "  ethernets:">>/etc/netplan/00-static-ip-config.yaml
	echo "    enp0s3:">>/etc/netplan/00-static-ip-config.yaml
	echo "      dhcp4: true">>/etc/netplan/00-static-ip-config.yaml
	echo "    enp0s8:">>/etc/netplan/00-static-ip-config.yaml
	echo "      addresses:">>/etc/netplan/00-static-ip-config.yaml
	echo "      - 192.168.56.2/30">>/etc/netplan/00-static-ip-config.yaml
	echo "      nameservers:">>/etc/netplan/00-static-ip-config.yaml
	echo "        addresses:">>/etc/netplan/00-static-ip-config.yaml
	echo "        - 1.1.1.1">>/etc/netplan/00-static-ip-config.yaml
	echo "        - 1.0.0.1">>/etc/netplan/00-static-ip-config.yaml
	echo "  version: 2">>/etc/netplan/00-static-ip-config.yaml
	sudo netplan apply
	$CURRENT_IP="ip addr show | grep "enp0s8" | grep "inet" | awk '{ print $2 }'"
	if [[ $CURRENT_IP = "192.168.56.2/30" ]]
	then
		echo "Static IP successfully set."
	else
		echo "Static IP failed: $CURRENT_IP"
	fi
[x] You have to change the default port of the SSH service by the one of your choice. SSH access HAS TO be done with publickeys. SSH root access SHOULD NOT be allowed directly, but with a user who can be root.
- I did a following shell script to change the settings in the server:
	
	sudo --preserve-env=USER /usr/bin/env ./config-ssh.sh
	
	#!/bin/bash
	sed -i 's/#Port 22/Port 50486/' /etc/ssh/sshd_config
	sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_confi
	sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
	echo "AllowUsers $USER" >>/etc/ssh/sshd_config
- This changes port from the default one to 50486, it also esplicitly prohibits user to login as root user. It also allows only user that was created to take contact with one's username. PubkeyAuthentication is at this point allowed.

- I also imported my SSH key during installation from my github account to authorized_keys file.
- This I could have also achieved with command ssh-copy-id command from the host by temporarily allowing password authentication in ssh config file.
ssh-copy-id -i path-to-public-key kafkan@192.168.55.1 -p 50486
- After pubkey has been transferred to the server, you should run password_off.sh
[x] You have to set the rules of your firewall on your server only with the services used outside the VM
- I use ufw (uncomplicated firewall), which was installed by default. I set my firewall rules followingly:
	sudo ufw default deny incoming
	sudo ufw default allow outgoing
	sudo ufw allow from 192.168.56.1 proto tcp to any port 50486
- This allows access from my desktop, and denies inbound connections and allows ones out.
	sudo ufw allow 443
- This allows HTTPS connections for serving the website.
	sudo ufw enable
- This enables the firewall.
- To test that rules work for the firewall, you can delete them by using sudo ufw numbered.
	sudo ufw numbered 
	sudo ufw delete <number>
- To test that firewall works, you can try to access 192.168.56.2 with your browser, it should show apache2 page, but when you remove the port 80 from the list, it will no longer work. 
[ ] You have to set a DOS (Denial Of Service Attack) protection on your open ports of your VM.
- I installed fail2ban after running comparison between ssh-guard and fail2ban.
	sudo apt-get install fail2ban
- We can check status of the service:
	systemctl status fail2ban
	fail2ban-client status
- We are going to set sshd settings through jail.d folder by adding a local file, since jail.conf is overwritten when updated. fail2ban is configured so, that it will first do the conf file and the local settings will override ones that have been set by conf.
- You cannot start fail2ban, if you have settings in jail.local that try to control a program that you do not have.
	systemctl restart fail2ban
- You can ban an IP with following command:
	sudo fail2ban-client set sshd banip <ip-address>
	sudo fail2ban-client set sshd unbanip <ip-address>
[x] You have to set a protection against scans on your VM’s open ports
	I've installed portsentry to guard VM's open ports. To configure settings, I did a following shell script:

	configure_portsentry.sh
	#!/bin/bash
	sudo /etc/init.d/portsentry stop
	sed -i 's/TCP_MODE=\"tcp\"/TCP_MODE=\"atcp\"/' /etc/default/portsentry
	sed -i 's/UDP_MODE=\"udp\"/UDP_MODE=\"audp\"/' /etc/default/portsentry
	sed -i 's/BLOCK_UDP=\"0\"/BLOCK_UDP=\"1\"/' /etc/portsentry/portsentry.conf
	sed -i 's/BLOCK_TCP=\"0\"/BLOCK_TCP=\"1\"/' /etc/portsentry/portsentry.conf
	sed -i 's/KILL_ROUTE=\"\/sbin\/route add -host $TARGET$ reject\"/#KILL_ROUTE=\"\/sbin\/route add -host $TARGET$ reject\"/' /etc/portsentry/portsentry.conf
	sed -i 's/#KILL_ROUTE=\"\/sbin\/iptables -I INPUT -s $TARGET$ -j DROP\"/KILL_ROUTE=\"\/sbin\/iptables -I INPUT -s $TARGET$ -j DROP\"/' /etc/portsentry/portsentry.conf
	sudo /etc/init.d/portsentry start

	To test that portsentry has been configured properly, I followed this tutorial:
	https://www.computersecuritystudent.com/UNIX/UBUNTU/1204/lesson14/index.html
	using nmap security scanner I scanned ports from 1 - 65535.
	nmap -p 1-65535 -T4 -A -v -PE -PS22,25,80 -PA21,23,80 192.168.56.2

	This led to that portsentry blocked my SSH access from 192.168.56.1
	To clean my trace from the server, I edited following files:
	/etc/hosts.deny
	/var/lib/portsentry/portsentry.blocked.atcp
	/var/lib/portsentry/portsentry.blocked.tcp
	/var/lib/portsentry/portsentry.history
	and checked if 192.168.56.1 appears on the netstat list,
	to clear the files, for the ip, it could be achieved with a shell script.

[x] Stop the services you don’t need for this project.
	- I created a shell script called stop_extra_services.sh, which shuts down extra services on the server.
	- I concluded that services you don't need for this project are following:
		apt-daily
		apt-daily upgrade
		cloud-init
		snapd
	- A detailed description of each running service can be found in stop_extra_services.sh

[x] Create a script that updates all the sources of package, then your packages and which logs the whole in a file named /var/log/update_script.log. Create a scheduledtask for this script once a week at 4AM and every time the machine reboots.

	Created first script to run update and upgrade. Update updates apt repositories, that what updates there are to be downloaded in the first place and -y option accepts all.
	Both are run seperately to get seperate entries to the logfile.
	#!/bin/bash
	sudo apt-get update -y >>/var/log/update_script.log
	sudo apt-get upgrade -y >>/var/log/update_script.log

	Created auto_update_system_packages.sh, which creates a task with to run:
	sudo touch /usr/local/bin/update_system_packages.sh

	#!/bin/bash
	rm /etc/cron.d/update-system-packages
	touch /etc/cron.d/update-system-packages
	echo 0 4 * *	root	sudo /usr/local/bin/run_update_packages.sh >>/etc/cron.d/update-system-packages
	@reboot    root    sudo /usr/local/bin/run_update_packages.sh >>/etc/cron.d/update-system-packages

[x] Make a script to monitor changes of the /etc/crontab file and sends an email to root, if it has been modified. Create a scheduled script task every day at midnight.
	Created a script to monitor changes in /etc/crontab file by using sha256 checksum of the file.
	If checksum is changed, the new checksum is saved to /var/log/ to a file, and $diff is sent to root,
	accompanying with contents of the changed file.

##Web part
- Self-Signed SSL
[ ] You have to set a web server who should BE available on the VM’s IP
or an host(init.login.com for exemple) Choose between nginx and apache.
- [Tutorial on Wordpress on LEMP](https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lemp-on-ubuntu-18-04)
- LEMP comes from words Linux, Nginx (pronounced enginex), MySQL and PHP.
- [Tutorial on installing LEMP stack](https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-ubuntu-18-04)
- I initially felt more  to create a webserver.
	
[ ] You have to set a self-signed SSL on all of your services.
- req -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 365 -out certificate.pem
- openssl x509 -text -noout -in certificate.pem
- openssl pkcs12 -inkey key.pem -in certificate.pem -export -out certificate.p12
- openssl pkcs12 -in certificate.p12 -noout -info

[ ] You have to set a web "application" from those choices.
- I will set our game's prequel to the server. 

##Deployment part
[ ] Propose a functional solution for deployment automation.

##VPS providers
- VPS (Virtual Private Server)
- VPS also has a firewall to add an extra layer of protection to your server.
- VPS allows you to give a DNS domain name.
Hostinger 3,95 / month
DigitalOcean $5 / month
Louhi 12,95eur
Louhi
12,82 eur
Public IP address. Reverse DNS.

Hostinger
1 vCPU
20GB SSD
1 TB
dedicated IP-address
Root Access
3,95e / month

List of public cloud service providers in the public cloud:
    - Amazon Web Services
    - Microsoft Azure
    - Google Cloud Platform
    - Oracle Cloud Infrastructure
    - Softlayer
    - Rackspace Public Cloud
    - IBM Cloud
    - Digital Ocean
    - Bigstep
    - Hetzner
    - Joyent
    - CloudSigma
    - Alibaba Cloud
    - OVH
    - OpenNebula
    - Exoscale
    - Scaleway
    - CloudStack
    - AltCloud
    - SmartOS

NextCloud
[Watch a Video of the configuration here](https://www.youtube.com/watch?v=lhWSek6zyrs)

- NEXT TASK:
	- Instead of Wordpress, do a proxy Node.js backend with content!
	- https://www.sitepoint.com/configuring-nginx-ssl-node-js/
	- Create a shell script that removes blocked ip from the files, and reboots the computer.

FUTURE:
You can buy a domain name.
How to attach ip-address to the hostname
ip address is your host's IP address.
NextCloud is LearnLinux
nextcloud to subdomain
nslookup nextcloud.learnlinux.cloud
Install a database.
