FROM nimmis/apache-php7

# Installation de php-dev (phpize)
RUN apt-get update -y \
    && apt-get install -y php7.0-dev php7.0-mbstring php7.0-sybase\
    git

# Installation de Librerias PHP
RUN apt-get install -y php7.0-mbstring php7.0-sybase

# Installation de otras librerias
RUN apt-get install git

# Enable proxy apache2 modules
RUN a2enmod proxy
RUN a2enmod proxy_http
RUN a2enmod headers
RUN a2enmod rewrite

# Install xdebug
RUN cd /root \
    && wget http://xdebug.org/files/xdebug-2.6.0.tgz \
    && tar -xvzf xdebug-2.6.0.tgz \
    && cd xdebug-2.6.0 \
    && phpize \
    && ./configure \
    && make \
    && cp modules/xdebug.so /usr/lib/php/20151012 \
    && echo "zend_extension = /usr/lib/php/20151012/xdebug.so" >> /etc/php/7.0/apache2/php.ini

COPY ./config_files/xdebug.ini /etc/php/7.0/mods-available/xdebug.ini   
# Config /etc/php/7.0/mods-available/xdebug.ini
# to correctly set the remote_host to your host computer's IP address
ARG IP_HOST
RUN sed -i "s/xdebug\.remote_host\=.*/xdebug\.remote_host\=$IP_HOST/g" /etc/php/7.0/mods-available/xdebug.ini

RUN phpenmod xdebug

# Activate rewrite extension
RUN a2enmod rewrite



