#!/bin/bash
sudo touch /etc/fail2ban/jail.local
echo -e "[DEFAULT]\nignoreip = 192.168.42.2\nbantime = 600\nfindtime = 600\nmaxretry = 3\nbackend = auto\nusedns = warn\ndestemail = root@localhost\nsendername = Fail2BanAlerts">>/etc/fail2ban/jail.local
echo -e "banaction = iptables-multiport\nmta = mail\nprotocol = tcp\nchain = INPUT\naction_ = %(banaction)s[name=%(__name__)s, port=\"%(port)s\", protocol=\"%(protocol)s\", chain=\"%(chain)s\"]\naction_mw = %(banaction)s[name=%(__name__)s, port=\"%(port)s\", protocol=\"%(protocol)s\", chain=\"%(chain)s\"] %(mta)s-whois[name=%(__name__)s, dest=\"%(destemail)s\", protocol=\"%(protocol)s\", chain=\"%(chain)s\", sendername=\"%(sendername)s\"]\naction_mwl = %(banaction)s[name=%(__name__)s, port=\"%(port)s\", protocol=\"%(protocol)s\", chain=\"%(chain)s\"] %(mta)s-whois-lines[name=%(__name__)s, dest=\"%(destemail)s\", logpath=%(logpath)s, chain=\"%(chain)s\", sendername=\"%(sendername)s\"]\naction = %(action_)s">>/etc/fail2ban/jail.local
echo -e "[sshd]\n\nenabled	= true\nport	= 50486\nfilter	= sshd\nbanaction	= ufw\nbackend	= systemd\nmaxretry	= 5\nbantime	= 600\n" >>/etc/fail2ban/jail.local
echo -e "[nginx-limit-req]\nenabled = true\nport = http,https\nfilter = nginx-limit-req\nlogpath = /var/log/nginx/error.log\nmaxretry = 10\nfindtime = 60\nbantime = 172800\naction = iptables-multiport[name=ReqLimit, port=\"http, https\", protocol=tcp]\n">>/etc/fail2ban/jail.local
echo -e "[nginx-botsearch]\n\nenabled  = true\nport     = http, https\nfilter   = nginx-botsearch\nlogpath  = /var/log/nginx/access.log\nmaxretry = 2\n">>/etc/fail2ban/jail.local
echo -e "[nginx-http-auth]\n\nenabled	= true\nfilter	= nginx-http-auth\nport	= http, https\nlogpath	= /var/log/nginx/error.log">>/etc/fail2ban/jail.local
echo -e "[nginx-noscript]\n\nenabled	= true\nport	= http, https\nfilter	= nginx-noscript\nlogpath	= /var/log/nginx/access.log\nmaxretry = 6">>/etc/fail2ban/jail.local
echo -e "[nginx-nohome]\n\nenabled  = true\nport     = http, https\nfilter   = nginx-nohome\nlogpath  = /var/log/nginx/access.log\nmaxretry = 2">>/etc/fail2ban/jail.local
echo -e "[http-get-dos]\nenabled	= true\nport = http, https\nfilter 	= http-get-dos\nlogpath	= /var/log/nginx/access.log\nmaxretry = 400\nfindtime = 400\nbantime = 200\naction=iptables[name=HTTP, port=http, protocol=tcp]\n">>/etc/fail2ban/jail.local
sudo rm /etc/fail2ban/filter.d/nginx-http-auth.conf
sudo touch /etc/fail2ban/filter.d/nginx-http-auth.conf
echo -e "[Definition]\n\nfailregex = ^ \\[error\\] \\d+#\\d+: \\*\\d+ user \"\\S+\":? (password mismatch|was not found in \".*\"), client: <HOST>, server: \\S+, request: \"\\S+ \\S+ HTTP/\\d+\\.\\d+\", host: \"\\S+\"\\s*$\n^ \\[error\\] \\d+#\\d+: \\*\\d+ no user/password was provided for basic authentication, client: <HOST>, server: \\S+, request: \"\\S+ \\S+ HTTP/\\d+\\.\\d+\", host: \"\\S+\"\\s*$\n\n\nignoreregex =">>/etc/fail2ban/filter.d/nginx-http-auth.conf
sudo rm /etc/fail2ban/filter.d/nginx-noscript.conf
sudo touch /etc/fail2ban/filter.d/nginx-noscript.conf
echo -e "[Definition]\n\nfailregex = ^<HOST> -.*GET.*(\\.php|\\.asp|\\.exe|\\.pl|\\.cgi|\\.scgi)\n\nignoreregex =">>/etc/fail2ban/filter.d/nginx-noscript.conf
sudo rm /etc/fail2ban/filter.d/nginx-nohome.conf
sudo touch /etc/fail2ban/filter.d/nginx-nohome.conf
echo -e "[Definition]\n\nfailregex = ^<HOST> -.*GET .*/~.*\n\nignoreregex =">>/etc/fail2ban/filter.d/nginx-nohome.conf
sudo rm /etc/fail2ban/filter.d/http-get-dos.conf
sudo touch /etc/fail2ban/filter.d/http-get-dos.conf
echo -e "[Definition]\n\nfailregex = ^<HOST> -.*\"(GET|POST).*\nignoreregex =">>/etc/fail2ban/filter.d/http-get-dos.conf
systemctl start fail2ban
echo "Set fail2ban jails for ssh and nginx server."
