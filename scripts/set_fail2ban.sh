#!/bin/bash
sudo touch /etc/fail2ban/jail.d/sshd.local
echo -e "[sshd]\n\nenabled	= true\nport	= 50486\nfilter	= sshd\nbanaction	= ufw\nbackend	= systemd\nmaxretry	= 5\nbantime	= 600" >>/etc/fail2ban/jail.d/sshd.local
sudo touch /etc/fail2ban/jail.d/http-get-dos.local
echo -e "[http-get-dos]\nenabled = true\nport = http,https\nfilter = http-get-dos\nlogpath = /var/log/apache*/access.log\nmaxretry = 400\nfindtime = 400\nbantime = 200\nignoreip = 192.168.56.2\naction = iptables[name=HTTP, port=http, protocol=tcp]">>/etc/fail2ban/jail.d/http-get-dos.local
sudo touch /etc/fail2ban/jail.d/nginx-badbots.local
echo -e "[nginx-badbots]\n\nenabled  = true\nport     = http, https\nfilter   = nginx-badbots\nlogpath  = /var/log/nginx/access.log\nmaxretry = 2">>/etc/fail2ban/jail.d/nginx-badbots.local
sudo touch /etc/fail2ban/jail.d/nginx-http-auth.local
echo -e "[nginx-http-auth]\n\nenabled	= true\nfilter	= nginx-http-auth\nport	= http, https\nlogpath	= /var/log/nginx/error.log">>/etc/fail2ban/jail.d/nginx-http-auth.local
sudo touch /etc/fail2ban/jail.d/nginx-no-script.local
echo -e "[nginx-noscript]\n\nenabled	= true\nport	= http, https\nfilter	= nginx-noscript\nlogpath	= /var/log/nginx/access.log\nmaxretry = 6">>/etc/fail2ban/jail.d/nginx-no-script.local
sudo touch /etc/fail2ban/jail.d/nginx-nohome.local
echo -e "[nginx-nohome]\n\nenabled  = true\nport     = http, https\nfilter   = nginx-nohome\nlogpath  = /var/log/nginx/access.log\nmaxretry = 2">>/etc/fail2ban/jail.d/nginx-nohome.local
sudo touch /etc/fail2ban/jail.d/nginx-noproxy.local
echo -e "[nginx-noproxy]\n\nenabled	= true\nport	= http, https\nfilter	= nginx-noproxy\nlogpath	= /var/log/nginx/access.log\nmaxretry	= 2">>/etc/fail2ban/jail.d/nginx-noproxy.local
sudo touch /etc/fail2ban/jail.d/nginx-req-limit.local
echo -e "[nginx-req-limit]\nenabled = true\nfilter = nginx-req-limit\naction = iptables-multiport[name=ReqLimit, port=\"http,https\", protocol=tcp]\nlogpath = /var/log/nginx/*error.log\nfindtime = 600\nbantime = 7200\nmaxretry = 10">>/etc/fail2ban/jail.d/nginx-req-limit.local
sudo rm /etc/fail2ban/filter.d/nginx-http-auth.conf
sudo touch /etc/fail2ban/filter.d/nginx-http-auth.conf
echo -e "[Definition]\n\nfailregex = ^ \\[error\\] \\d+#\\d+: \\*\\d+ user \"\\S+\":? (password mismatch|was not found in \".*\"), client: <HOST>, server: \\S+, request: \"\\S+ \\S+ HTTP/\\d+\\.\\d+\", host: \"\\S+\"\\s*$\n^ \\[error\\] \\d+#\\d+: \\*\\d+ no user/password was provided for basic authentication, client: <HOST>, server: \\S+, request: \"\\S+ \\S+ HTTP/\\d+\\.\\d+\", host: \"\\S+\"\\s*$\n\n\nignoreregex =">>/etc/fail2ban/filter.d/nginx-http-auth.conf
sudo cp /etc/fail2ban/filter.d/apache-badbots.conf /etc/fail2ban/filter.d/nginx-badbots.conf
sudo touch /etc/fail2ban/filter.d/nginx-noscript.conf
echo -e "[Definition]\n\nfailregex = ^<HOST> -.*GET.*(\\.php|\\.asp|\\.exe|\\.pl|\\.cgi|\\.scgi)\n\nignoreregex =">>/etc/fail2ban/filter.d/nginx-noscript.conf
sudo touch /etc/fail2ban/filter.d/nginx-nohome.conf
echo -e "[Definition]\n\nfailregex = ^<HOST> -.*GET .*/~.*\n\nignoreregex =">>/etc/fail2ban/filter.d/nginx-noscript.conf
sudo touch /etc/fail2ban/filter.d/nginx-noproxy.conf
echo -e "[Definition]\n\nfailregex = ^<HOST> -.*GET http.*\n\nignoreregex =">>/etc/fail2ban/filter.d/nginx-noscript.conf
sudo touch /etc/fail2ban/filter.d/http-get-dos.conf
echo -e " [Definition]\n\nfailregex = ^<HOST> -.*\"(GET|POST).*\nignoreregex =">>/etc/fail2ban/filter.d/http-get-dos.conf
systemctl start fail2ban
echo "Set fail2ban jail for ssh and nginx server."
