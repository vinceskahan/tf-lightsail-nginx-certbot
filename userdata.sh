#!/bin/bash

echo "userdata start at `date`" >> /root/000-TERRAFORM-DATE
echo "(see the script at /var/lib/cloud/instance/user-data.txt for manual steps)" >> /root/000-TERRAFORM-DATE

# two steps, some packages are held back in the first pass
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y

# stuff we always add
apt-get install nginx vim git fail2ban iptables-persistent geoip-bin -y

# certbot software
apt-get install software-properties-common -y
add-apt-repository universe -y
add-apt-repository ppa:certbot/certbot -y
apt-get update
apt-get install certbot python-certbot-nginx -y

########################
#
# unfortunately google domains does not have a scriptable API
# so add an A record there pointing to the returned public ip
# from the terraform run.
#
# ssh into the box, sudo to root, and run:
#     certbot --nginx
#     certbot renew --dry-run
#     (verify certbot renew is in /etc/crontab or /etc/cron.*/*)
#     systemctl list-timers
#
# verify 443 is enabled in the lightsail console
# (the default is to 'not' have it enabled)
#
# and verify ssh is working
#     open https://fqdn
#     or use https://www.ssllabs/ssltest
#
# noninteractive would be:
# sudo certbot --nginx --agree-tos -m myemail@example.com -n -d host1.mydomain,host2.mydomain
# (assuming the hosts 'do' resolve in DNS)
#
# for Lightsail, make sure 443 is open in the Amazon console.  The default is 'not' open.
#
# REBOOT TO ENABLE fail2ban AND TO ENSURE THE SYSTEM COMES UP OK
#
########################

echo "userdata end   at `date`" >> /root/000-TERRAFORM-DATE
