#!/bin/bash
#rsync -a -e "ssh -p 50486" *.sh lol@192.168.56.2:/home/lol/scripts
#$1 is the path to the pubkey, and $2 is the address of the computer. 
ssh-copy-id -i $1 $2
rsync -a scripts/*.sh $2:/home/$3/scripts
