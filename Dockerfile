FROM ubuntu:latest

MAINTAINER Luke Sigler <luke.sigler@cetera.com> 

ENV DEBIAN_FRONTEND noninteractive

ENV HOME /home/developer

ENV LC_ALL en_US.UTF-8

ADD docker-entrypoint.sh /tmp/docker-entrypoint.sh

RUN chmod +x /tmp/docker-entrypoint.sh

RUN apt-get update && \
    apt-get install -y vim git wget fontconfig

RUN useradd dev && \
    echo "ALL            ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    cp /usr/share/zoneinfo/America/Los_Angeles /etc/localtime && \
    dpkg-reconfigure locales && \
    locale-gen en_US.UTF-8 && \
    /usr/sbin/update-locale LANG=en_US.UTF-8

RUN mkdir -p /home/developer/workspace

RUN chown -R dev:dev $HOME

USER dev

ENTRYPOINT ["docker-entrypoint.sh"]