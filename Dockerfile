FROM nimmis/apache

#from nimmis repo
MAINTAINER marxwang <marx.wang@gmail.com>

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive

ADD suhosin.asc /tmp
RUN \
 sed -e '1,3d' /etc/resolv.conf && \
 echo  "nameserver 8.8.8.8" >> /etc/resolv.conf && \
 echo "deb http://repo.suhosin.org/ debian-jessie main" > /etc/apt/sources.list.d/suhosin.list \
&& cat /tmp/suhosin.asc | apt-key add - &&\
apt-get update && \
apt-get install -y php5 libapache2-mod-php5  \
php5-fpm php5-cli php5-mysqlnd php5-pgsql php5-sqlite php5-redis \
php5-apcu php5-intl php5-imagick php5-mcrypt php5-json php5-gd php5-curl && \
php5enmod mcrypt && \
rm -rf /var/lib/apt/lists/* && \
cd /tmp && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
