#!/bin/bash
#This command stops the service in question, and stops it from restarting in system start-up. However, it can be activated by other applications:
#	systemctl stop <service>
#This completely disables the service by creating a link to /dev/null, the service cannot be started manually or activated by other applications
#	systemctl mask <service>
#Unmask reverses masking the link and restores the ability to enable or manually start the service.
#	systemctl unmask <service>
#systemctl stop apparmor.service
#AppArmor is a Linux Security Module implementation of name-based mandatory access controls. AppArmor confines
#individual programs to a set of listed files and posix 1003.1e draft capabilities.
#apport: is debugging software for Ubuntu.
#atd: Runs commands on given time.
systemctl stop cloud-init.service cloud-final.service cloud-init-local.service cloud-config.service
systemctl disable cloud-init.service cloud-final.service cloud-init-local.service cloud-config.service
systemctl mask cloud-init.service cloud-final.service cloud-init-local.service cloud-config.service
touch /etc/cloud/cloud-init.disabled
#Cloudinit is really for customization of images in the cloud. If for example you had a cluster of servers networked together then it would be handy, but not what this in mind.
#finalrd: generates a shutdown directory which systed-shutdown pivots during shutdown. There system shutdown
#can be finalised and arbitrary hooks can be executed off-root, to safely cleanup rootfs and perform
#any other shutdown tasks.
#getty@tty1.service: A getty is the generic name for a program which manages a terminal line and its connected terminal.
#Its purpose is to protect the system from unauthorized access. Generally, each getty process is started 
#by systemd and manages a single terminal line.
#grub-common.service: GRUB displays the boot menu at the next boot if it believes that the previous boot failed. This script
#informs it that the system booted successfully.
#keyboard-setup.service: This is a bit two-folded, should we not use the server and it's keyboard,
#but provide a headless access to the computer, then we could deactivate this.
#kmod-static-nodes.service: kmod is a multi-call binary which implements the programs used to control Linux Kernel modules.
#lvm2: Logical Volume Manager is a device mapper target that provides logical volume management for the Linux kernel.
#multipathd: The multipathd daemon is in charge of checking for failed paths.
#networkd-dispatcher: Networkd-dispatcher is a dispatcher daemon for systemd-networkd connection status changes.
#It is similar to NetworkManager-dispatcher, but is much more limited in the types of events it supports due to
#the limited nature of systemd-networkd. 
#polkit.service: Polkit works by delimiting distinct actions, e.g. running GParted, and delimiting users by group or by name,
#e.g. members of the wheel group. It then defines how – if at all – those users are allowed those actions, e.g.
#by identifying as members of the group by typing in their passwords. 
#portsentry.service: Portsentry is designed to detect and respond to portscans against a target host in real-time.
#rsyslog.service: Rsyslog is an open-source software utility used on UNIX and Unix-like computer systems for forwarding log messages in an IP network.
#setvtrgb.service: setvtrgb  sets  the  console color map in all virtual terminals according to custom values specified in a file or standard input.
#snapd.apparmor.service: Snap has a service for Apparmor, so that could be deactivated on the same go.
systemctl stop snapd.apparmor.service
systemctl stop snapd.seeded.service
systemctl stop snapd.service
systemctl stop snapd.socket
sudo apt purge snapdr
rm -rf ~/snap
sudo rm -rf /snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd
#ssh.service: SSH provides a secure channel over an unsecured network by using a client–server architecture.
#systemd-journal-flush.service: Flushes data of system log. Journald is a fundamental service in systemd linux and many other services depends on it.
#systemd-journal-journald.service: systemd-journald is a system service that collects and stores logging data.
#systemd-logind: a system service that manages user logins.
#systemd-modules-load.service: loads kernel modules.
#systemd-networkd-wait-online.service: waits for the network to be configured.
#systemd-networkd.service: It detects and configures network devices as they appear; it can also create virtual network devices.
#systemd-random-seed.service: Load and save the system random seed at boot and shutdown.
#systemd-remount-fs.service: Remount root and kernel file systems.
#systemd-resolved.service: A system service that provides network name resolution to local applications.
#systemd-sysctl.service: Configure kernel parameters at boot.
#systemd-sysusers.service: Creates system users and groups.
#systemd-timesyncd: syncronizes system time across the network.
#systemd-tmpfiles-setup-dev.service: creates, deletes, and cleans up volatile and temporary files and directories, based on the configuration file format and location.
#systemd-udev-settle.service: wait until all events that have been queued are done, so that all hardware have been discovered.
#systemd-udev-trigger.service
#systemd-update-utmp.service: write and audit utmp files on the startup.
#systemd-user-sessions.service: removes /run/nologin, to permit logins to the system.
#ufw.service: Service for Uncomplicated Firewall
#unattended-upgrades.service: The purpose of unattended-upgrades is to keep the computer current with the latest security (and other) updates automatically.
#user-runtime-dir@1000.service
#user@1000.service: manages resources for the user.
systemctl stop apt-daily.service apt-daily-upgrade.service apt-daily.timer apt-daily-upgrade.timer
systemctl mask apt-daily.service apt-daily-upgrade.service apt-daily.timer apt-daily-upgrade.timer
#These services were deactivated due we have cronjob to fetch newest updates once a week.
