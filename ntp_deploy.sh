#!/bin/bash


apt install ntp -y > /dev/null 2> /dev/null 
cp /etc/ntp.conf /etc/ntp.conf.bak && sed -i '/pool/d' /etc/ntp.conf
echo pool ua.pool.ntp.org >> /etc/ntp.conf #3
service ntp restart #restart ntp #4
echo "*/5 * * * * $PWD/ntp_verify.sh" | crontab