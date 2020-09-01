#!/bin/bash
cd /var/www/hiddengames_project && git fetch --all && git checkout --force "origin/master"yarn build --prefix /var/www/hiddengames_project
mv /var/www/hiddengames_project/build /var/www/hiddengames/build
