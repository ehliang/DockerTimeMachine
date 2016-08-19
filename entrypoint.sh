#!/bin/bash

groupadd ${AFP_GROUP}

useradd ${AFP_USER} -M 

echo ${AFP_USER}





mkdir -p /var/run/dbus
rm -f /var/run/dbus/pid
dbus-daemon --system
exec netatalk -d 
