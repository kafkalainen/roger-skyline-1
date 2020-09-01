#!/bin/bash
git clone https://github.com/kafkalainen/prelude_hg.git /var/www/hiddengames_project
cd /var/www/hiddengames_project
npm install --prefix /var/www/hiddengames_project react yarn
yarn build --prefix /var/www/hiddengames_project
mv /var/www/hiddengames_project/build/ /var/www/hiddengames/build
