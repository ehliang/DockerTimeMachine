#!/bin/bash
sed -i -e "s/AFP_USER/${AFP_USER}/g" /home/afp.conf
cat /home/afp.conf


groupadd ${AFP_GROUP}

useradd ${AFP_USER} -M 

chpasswd <<< ${AFP_USER}:${AFP_PASS}

echo ${AFP_USER}

chown ${AFP_USER}:${AFP_GROUP} /home/timeMachine


mkdir -p /var/run/dbus
rm -f /var/run/dbus/pid
dbus-daemon --system
exec netatalk -d 
