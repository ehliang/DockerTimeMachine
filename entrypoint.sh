#!/bin/bash
sed -i -e "s/AFP_USER/${AFP_USER}/g" /home/afp.conf
cat /home/afp.conf


if id -u ${AFP_USER} >/dev/null 2>&1; then
	echo "User exists"
else
	groupadd ${AFP_GROUP}
	useradd ${AFP_USER} -M 
	chpasswd <<< ${AFP_USER}:${AFP_PASS}
fi


echo ${AFP_USER}

chown ${AFP_USER}:${AFP_GROUP} /home/timeMachine


mkdir -p /var/run/dbus
rm -f /var/run/dbus/pid
dbus-daemon --system
exec netatalk -d 
