# Pull base image
FROM resin/rpi-raspbian:jessie
MAINTAINER Dieter Reuter <dieter@hypriot.com>

# Install dependencies
RUN apt-get update && apt-get install -y \
    cron \
    rsyslog \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Import crontab file
ADD ./crontab /etc/crontab
RUN touch /var/log/cron.log

# Define default command
CMD rsyslogd && cron && tail -f /var/log/syslog /var/log/cron.log
