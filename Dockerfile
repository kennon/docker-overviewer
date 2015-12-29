FROM ubuntu:14.04

# Make sure we don't get notifications we can't answer during building.
ENV    DEBIAN_FRONTEND noninteractive

RUN apt-get -y update; apt-get -y upgrade
RUN apt-get -y install python-numpy python-imaging git build-essential python-dev wget curl cron rsyslog

RUN git clone https://github.com/overviewer/Minecraft-Overviewer.git /srv/overviewer; cd /srv/overviewer; python setup.py build

ADD cron.d/overviewer /etc/cron.d/overviewer
ADD etc/overviewer.conf /etc/overviewer.conf

VOLUME ["/data"]

ADD scripts/start /start
RUN chmod +x /start

ADD scripts/generate /generate
RUN chmod +x /generate

CMD ["/start"]
