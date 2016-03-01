FROM python:2.7-onbuild
MAINTAINER Valentin Lab <valentin.lab@kalysto.org>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --force-yes -y --no-install-recommends collectd rrdcached snmp libsnmp30 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD etc/collectd/collectd.conf /etc/collectd/collectd.conf
#ADD etc/init.d/rrdcached /etc/init.d/rrdcached
ADD entrypoint.sh /entrypoint.sh

#add docker collectd plugin
#source code:https://github.com/yepengxj/docker-collectd-plugin.git 
#source code:https://github.com/lebauce/docker-collectd-plugin.git
ADD docker-collectd-plugin /docker-collectd-plugin

RUN chmod a+x /entrypoint.sh

VOLUME /etc/collectd/collectd.conf.d/
#VOLUME /var/lib/rrdcached/db
#VOLUME /var/run/rrdcached

#EXPOSE 42217

ENTRYPOINT /entrypoint.sh
