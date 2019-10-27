#!/bin/bash

echo "userdata run at `date`" >> /root/000-TERRAFORM-DATE

# two steps, some packages are held back in the first pass
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y

# stuff we always add
apt-get install nginx vim git -y

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
########################
