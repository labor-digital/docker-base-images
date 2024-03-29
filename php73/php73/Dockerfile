# TAG: labordigital/docker-base-images:php73
# Build: docker build -t labordigital/docker-base-images:php73 .
# Push: docker push labordigital/docker-base-images:php73

# Parent package is described here: https://hub.docker.com/_/php/
FROM php:7.3-apache

# Define author
MAINTAINER LABOR.digital <info@labor.digital>

# Set Label
LABEL description="LABOR Digital PHP7.3"

# Expose ports
EXPOSE 80
EXPOSE 443

# Set console to xterm to fix problems with nano and other console comands in pseudo-TTY connections
# @see http://stackoverflow.com/questions/27826241/running-nano-in-docker-container
ENV TERM=xterm

# Install sudo
RUN apt-get update && apt-get install -y sudo
RUN apt-get update && apt-get install -y vim nano

# Configure dpkg | Install locales, keyboard and timezone
COPY /conf/deb-preseed.txt /tmp/init_locales/deb-preseed.txt
RUN DEBIAN_FRONTEND=noninteractive \
	DEBCONF_NONINTERACTIVE_SEEN=true \
	debconf-set-selections /tmp/init_locales/deb-preseed.txt \
	&& apt-get update && apt-get install -y \
        locales \
	&& echo "Europe/Berlin" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata \
    && dpkg-reconfigure -f noninteractive locales \
	&& rm -rf /tmp/init_locales
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Create a dummy ssl cert
RUN apt-get update && \
    apt-get install -y openssl && \
    mkdir /opt/tmpssl && \
    mkdir /var/cert && \
    cd /opt/tmpssl && \
    openssl genrsa -des3 -passout pass:a2lamsoSsdf41 -out server.pass.key 2048 && \
    openssl rsa -passin pass:a2lamsoSsdf41 -in server.pass.key -out server.key && \
    rm server.pass.key && \
    openssl req -new -key server.key -out server.csr \
        -subj "/C=DE/ST=Rheinland-Pfalz/L=Mainz/O=LABOR - Agentur fuer moderne Kommunikation GmbH/OU=IT Department/CN=labor.systems" && \
    openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt && \
    cat server.crt server.key > merged.crt && \
    mv merged.crt /var/cert/ && \
    cd / && \
    rm -rf /opt/tmpssl

# Install intl
RUN apt-get update && \
    apt-get install -y libicu-dev && \
    docker-php-ext-install intl
	
# Install curl 
RUN apt-get install -y \
		curl \
		libcurl4-gnutls-dev \
	&& docker-php-ext-install -j$(nproc) curl
	
# Install zip extension
RUN apt-get install -y \
        libzip-dev \
        zip \
  && docker-php-ext-configure zip --with-libzip \
  && docker-php-ext-install zip

# Install mysql extension
RUN docker-php-ext-install pdo pdo_mysql mysqli
	
# Install GD extension
RUN apt-get install -y \
        libwebp-dev \
		libpng-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
	&& yes '' | pecl install -f mcrypt \
	&& echo "extension=mcrypt.so" > /usr/local/etc/php/conf.d/mcrypt.ini \
    && docker-php-ext-install -j$(nproc) \
		iconv \
    && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
        --with-webp-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) \
		gd

# Enable apcu cache
RUN pecl install \
		apcu \
	&& docker-php-ext-enable \
		apcu

# Install mbstring
RUN docker-php-ext-install \
	mbstring

# Install opcache
RUN docker-php-ext-install \
	opcache
	
# Install fileinfo
RUN docker-php-ext-install -j$(nproc) fileinfo

# Prepare apache modules
RUN a2enmod rewrite \
	&& a2enmod ssl \
	&& a2enmod deflate \
	&& a2enmod headers \
	&& a2enmod expires \
	&& a2dismod -f autoindex

# Copy VHosts-Conf, Crt and php.ini
COPY conf/000-default.conf /etc/apache2/sites-available/
COPY conf/apache2.conf /etc/apache2/
COPY conf/php.ini /usr/local/etc/php/

# Setup global aliases
COPY conf/.bashrc /root/

# Use bash as our default shell
SHELL ["/bin/bash", "-c"]

# Add our scripts
COPY opt /opt
RUN find /opt -type f -iname "*.sh" -exec chmod +x {} \;

# Create data and logs directory and set the correct folder permissions
RUN source /root/.bashrc \
	&& ensure_dir /var/www/html_data \
	&& ensure_dir /var/www/html \
	&& ensure_dir /var/www/logs

ENTRYPOINT ["/opt/bootstrap.sh"]
