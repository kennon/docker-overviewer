FROM ubuntu:14.04

# Make sure we don't get notifications we can't answer during building.
ENV    DEBIAN_FRONTEND noninteractive

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get -y update; apt-get -y upgrade
RUN apt-get install -y wget curl cron rsyslog

RUN wget -O - http://overviewer.org/debian/overviewer.gpg.asc | sudo apt-key add -
RUN echo "deb http://overviewer.org/debian ./" >> /etc/apt/sources.list
RUN apt-get -y update; apt-get -y install minecraft-overviewer

ADD ./cron.d/overviewer /etc/cron.d/overviewer
ADD ./etc/overviewer.conf /etc/overviewer.conf

VOLUME ["/data"]

ADD ./scripts/start /start
RUN chmod +x /start

ADD ./scripts/generate /generate
RUN chmod +x /generate

CMD ["/start"]
