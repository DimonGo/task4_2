#!/bin/bash


RUN=`service ntp start`
ST=`service ntp status | grep dead`
STF=`systemctl status ntp.service | grep failed`

if [[ $ST="dead" ]] && [[ $STF="failed" ]]; then
		echo "NOTICE: ntp is not running"
		$RUN 
fi
#shows difference between two files
file_diff=`diff -u0 /etc/ntp.conf.bak /etc/ntp.conf`
#delete default servers from conf
sed -i '/pool/d' /etc/ntp.conf
echo pool ua.pool.ntp.org >> /etc/ntp.conf
systemctl restart ntp
echo NOTICE: /etc/ntp.conf was changed. Calculated diff:
echo $file_diff