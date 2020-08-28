#!/bin/bash
git clone https://github.com/kafkalainen/prelude_hg.git /home/kafkan223/hiddengames_project
cd /home/kafkan223/hiddengames_project
npm install --prefix /home/kafkan223/hiddengames_project react yarn
yarn build --prefix /home/kafkan223/hiddengames_project
mv /home/kafkan223/hiddengames_project/build/ /home/kafkan223/hiddengames/
