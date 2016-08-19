FROM debian:latest
ENV NETATALK_VER 3.1.9
ENV AFP_USER "user"
ENV AFP_PASS "password"
ENV AFP_GROUP "timemachine"
ENV DEPSI curl
ENV DEBIAN_FRONTEND noninteractive
ENV DEPS build-essential libevent-dev libssl-dev libgcrypt11-dev libkrb5-dev libpam0g-dev libwrap0-dev libdb-dev libtdb-dev libmysqlclient-dev libavahi-client-dev libacl1-dev libldap2-dev libcrack2-dev systemtap-sdt-dev libdbus-1-dev libdbus-glib-1-dev libglib2.0-dev libtracker-sparql-1.0-dev libtracker-miner-1.0-dev tracker curl

RUN apt-get update && apt-get install --yes --fix-missing --no-install-recommends \
	${DEPS} \
	&& curl -L "http://downloads.sourceforge.net/project/netatalk/netatalk/${NETATALK_VER}/netatalk-${NETATALK_VER}.tar.gz" > "netatalk.tar.gz" \
	&& tar xvf "netatalk.tar.gz"

WORKDIR netatalk-${NETATALK_VER}

RUN ./configure \ 
	--sysconfdir=/home \
	--with-init-style=debian-systemd \
        --without-libevent \
        --without-tdb \
        --with-cracklib \
        --enable-krbV-uam \
        --with-pam-confdir=/etc/pam.d \
        --with-dbus-sysconf-dir=/etc/dbus-1/system.d \
        --with-tracker-pkgconfig-version=1.0 \
	&& make \ 
	&& make install \
	&& mkdir /home/timeMachine \
	&& touch /var/log/afpd.log

COPY afp.conf /home/afp.conf
COPY entrypoint.sh /entrypoint.sh

VOLUME ["/home/timeMachine"]
EXPOSE 548 5353

CMD ["/entrypoint.sh"]


