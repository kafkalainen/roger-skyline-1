#!/bin/bash
#rsync -a -e "ssh -p 50486" *.sh lol@192.168.56.2:/home/lol/scripts
#$1 is the path to the pubkey, and $2 is the address of the computer. 
ssh-copy-id -i /home/joonasnivala/.ssh/id_rsa.pub $1
rsync -a scripts/*.sh $1:/home/$2/scripts
