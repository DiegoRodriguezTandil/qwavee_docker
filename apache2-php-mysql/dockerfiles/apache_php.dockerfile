FROM nimmis/apache-php7

# Installation de php-dev (phpize)
RUN apt-get update -y \
    && apt-get install -y php7.0-dev php7.0-mbstring \
    && git

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

RUN phpenmod xdebug

# Activate rewrite extension
RUN a2enmod rewrite



