#!/bin/bash
sudo /usr/local/bin/ssh_password_off.sh
sudo /usr/local/bin/apt_get_minimum_packages.sh
sudo --preserve-env=USER /usr/bin/env /usr/local/bin/add_sudo_priviledges.sh
sudo /usr/local/bin/configure_netplan.sh
sudo --preserve-env=USER /usr/bin/env /usr/local/bin/configure_ssh.sh
sudo /usr/local/bin/set_ufw_firewall.sh
sudo /usr/local/bin/set_fail2ban.sh
sudo /usr/local/bin/set_portsentry.sh
sudo /usr/local/bin/stop_extra_services.sh
sudo /usr/local/bin/auto_update_system_packages.sh
sudo /usr/local/bin/create_cronjob_for_crontab_monitor.sh
sudo /usr/local/bin/ssl_certificate.sh
sudo /usr/local/bin/mariadb_settings.sh 
sudo /usr/local/bin/node_js_settings.sh
sudo /usr/local/bin/deploy_hiddengames.sh
sudo /usr/local/bin/nginx_settings.sh
sudo --preserve-env=USER /usr/local/bin/create_cronjob_for_node_js.sh
echo "Installation complete. Please reboot the system in order for portsentry to fully activate and to set webpage running."
