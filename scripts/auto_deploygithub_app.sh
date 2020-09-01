#!/bin/bash
git config --global user.name "[kafkan223]"
git config --global user.email "[root@localhost]"
sudo mkdir /var/www/.ssh
sudo chown -R www-data:www-data /var/www/.ssh/
sudo -Hu www-data ssh-keygen -t rsa
sudo cat /var/www/.ssh/id_rsa.pub
touch /etc/cron.d/auto-deploy-hg
echo "*/1 * * * *	www-data    /var/www/auto_deploy_hg.sh">>/etc/cron.d/auto-deploy-hg
echo -e "Copy public key to your remote repository to start auto-deployment."
