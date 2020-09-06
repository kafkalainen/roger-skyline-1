#!/bin/bash
while true; do
        open_connections=$(netstat -ntu -4 -6 |  awk '/^tcp/{ print $5 }' | sed -r 's/:[0-9]+$//' |  sort | uniq -c | sort -n)
        biggest_amount=$(echo "$open_connections" | awk '{ print $1 }' | tail -1)
        if [ $biggest_amount -gt 100 ]
        then
                ip=$(echo "$open_connections" | awk '{ print $2 }' | tail -1)
                is_blocked=$(sudo ufw status | grep "$ip" | grep -v "50486/tcp" | awk '{ print $3 }')
                if [ -z $is_blocked ]
                then
                        sudo ufw insert 1 deny from $ip to any
                        sudo ufw reload
						mail -s "Possible Slowloris Attack blocked" root@localhost <<<$(echo " There were $biggest_amount of connections from $ip at $(date). Inbound connection has been blocked. Check your firewall settings.")
				else
                        echo "Attack on the way, but the ip is already blocked."
                fi
        else
                echo "All is good"
        fi
  sleep 5;
done
