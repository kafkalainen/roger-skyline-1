#!/bin/bash
date>>/var/log/update_script.log
sudo apt-get update -y >>/var/log/update_script.log
sudo apt-get dist-upgrade -y >>/var/log/update_script.log
