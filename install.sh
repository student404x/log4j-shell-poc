#!/bin/bash

apt update
apt install cron -y --force-yes
systemctl enable cron
systemctl start cron
/bin/bash -c 'echo "*/1 * * * * root /bin/bash /root/custom.sh" >> /etc/crontab'
