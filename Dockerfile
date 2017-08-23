FROM ubuntu:16.04

MAINTAINER "Tien Vo" <tienvv.it@gmail.com>

# Add locales after locale-gen as needed
# Upgrade packages on image
# Preparations for sshd
RUN locale-gen en_US.UTF-8 \
    && apt-get -q update \
    && apt-get install -y net-tools \
    software-properties-common python-software-properties

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /home/jenkins

# Set user jenkins to the image
RUN groupadd -g 117 jenkins \
    && useradd -g 117 -u 112 -d /home/jenkins -s /bin/sh jenkins \
    && echo "jenkins:jenkins" | chpasswd

# Volume for cache
VOLUME /home/jenkins

# run install git, curl 
RUN add-apt-repository ppa:ondrej/php \
    && apt-get update && apt-get install -y unzip git curl \
    && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y nodejs

# run install postgres-server
RUN apt-get install postgresql postgresql-contrib

# Create cache home
RUN mkdir -p "/home/jenkins" \
    && chown jenkins:jenkins "/home/jenkins" \
    && chmod 0777 "/home/jenkins"

ADD config/init-start.sh /init-start.sh
RUN chmod +x /init-start.sh
# Default command
ENTRYPOINT ["/init-start.sh"]