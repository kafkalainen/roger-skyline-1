#!/bin/bash
cd /var/www/hiddengames_project/
if [ -f latest_log ];
then
        echo "Exists."
else
        touch latest_log
        echo "Created log."
fi
git pull git@github.com:kafkalainen/prelude_hg.git
#git checkout --force "origin/master"
HEAD=$(git log -n 1 | grep commit | awk '{ print $2 }')
#echo "$(diff <(echo "$HEAD") latest_log)"
#HEAD=$(git log -n 1 | grep commit | awk '{ print $2 }')
DIFF=$(diff <(echo "$HEAD") latest_log)
if [ -n "$DIFF" ];
then
        echo "$HEAD">latest_log
        echo "Changed: running build."
        yarn build
        sleep 70
        rm -rf /var/www/hiddengames/build
        mv /var/www/hiddengames_project/build /var/www/hiddengames/build
else
        echo "Unchanged: keeping old build."
fi
