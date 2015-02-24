FROM ubuntu:14.04
MAINTAINER Arnaud de Mouhy <arnaud@flyingpingu.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nginx python python-dev python-pip

RUN DEBIAN_FRONTEND=noninteractive pip install Jinja2

RUN rm /etc/nginx/sites-enabled/default
ADD html/ /usr/share/nginx/html/
ADD sites-enabled/ /etc/nginx/sites-enabled/
ADD ssl/ /etc/nginx/ssl/
ADD nginx.conf /etc/nginx/

ADD scripts/ /scripts/

VOLUME ["/etc/nginx/ssl/", "/scripts/"]

EXPOSE 80 443

WORKDIR /scripts/
ENTRYPOINT ["python", "startup.py"]
CMD []
