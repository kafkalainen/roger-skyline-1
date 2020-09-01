#!/bin/bash
git config --global user.name "[kafkan223]"
git config --global user.email "[root@localhost]"
sudo mkdir /home/$USER/.ssh
sudo -Hu $USER ssh-keygen -t rsa
sudo chmod 400 /home/$USER/.ssh/id_rsa.pub
sudo chmod 400 /home/$USER/.ssh/id_rsa
sudo touch /home/$USER/.ssh/config
echo "host github.com">>/home/$USER/config
echo " HostName github.com">>/home/$USER/config
echo " IdentityFile /home/$USER/.ssh/id_rsa">>home/$USER/config
echo " User git">>home/$USER/config
sudo chmod 400 /home/$USER/.ssh/id_rsa
touch /etc/cron.d/auto-deploy-hg
echo 'PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'>>/etc/cron.d/auto-deploy-hg
echo "*/5 * * * *	$USER    /var/www/auto_deploy_hg.sh">>/etc/cron.d/auto-deploy-hg
sudo cat /home/$USER/.ssh/id_rsa.pub
sudo mv /usr/local/bin/auto_deploy_hg.sh /var/www/
sudo chown -R $USER:$USER /var/www/
echo -e "Copy public key to your remote repository to start auto-deployment. Use this for cloning:"
echo -e "git clone git@github.com:username/repo_name.git repo_name'"
