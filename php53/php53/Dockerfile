# TAG: labordigital/docker-base-images:php53
# Build: docker build -t labordigital/docker-base-images:php53 .
# Push: docker push labordigital/docker-base-images:php53

# Parent package is described here: https://hub.docker.com/r/orsolin/docker-php-5.3-apache/
FROM orsolin/docker-php-5.3-apache

# Define author
MAINTAINER LABOR.digital <info@labor.digital>

# Set Label
LABEL description="LABOR Digital PHP5.3"

# Expose ports
EXPOSE 80
EXPOSE 443

# Set console to xterm to fix problems with nano and other console comands in pseudo-TTY connections
# @see http://stackoverflow.com/questions/27826241/running-nano-in-docker-container
ENV TERM=xterm

# Install sudo
RUN apt-get update && apt-get install -y --force-yes sudo

# Configure dpkg | Install locales, keyboard and timezone
COPY /conf/deb-preseed.txt /tmp/init_locales/deb-preseed.txt
RUN DEBIAN_FRONTEND=noninteractive \
	DEBCONF_NONINTERACTIVE_SEEN=true \
	debconf-set-selections /tmp/init_locales/deb-preseed.txt \
	&& apt-get update && apt-get install -y --force-yes \
        locales \
	&& echo "Europe/Berlin" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata \
    && dpkg-reconfigure -f noninteractive locales \
	&& rm -rf /tmp/init_locales
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL de_DE.UTF-8

# Create a dummy ssl cert
RUN apt-get update && \
    apt-get install -y --force-yes openssl && \
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

# Install curl 
RUN apt-get install -y --force-yes \
		curl \
		libcurl4-gnutls-dev \
	&& docker-php-ext-install curl

# Install mysql extension
RUN docker-php-ext-install pdo pdo_mysql mysqli mysql
	
# Install GD extension
RUN apt-get install -y --force-yes \
		libpng-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
    && docker-php-ext-install \
		iconv \
    && docker-php-ext-install \
		gd

# Install mbstring
RUN docker-php-ext-install \
	mbstring
	
# Install fileinfo
RUN docker-php-ext-install fileinfo

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

# Setup a root bashrc for the composer-alias
COPY conf/.bashrc /root/

# Copy permissions.sh
COPY opt/permissions.sh /opt/permissions.sh
RUN chmod +x /opt/permissions.sh

# Copy bootstrap-project.sh
COPY opt/bootstrap-project.sh /opt/bootstrap-project.sh
RUN chmod +x /opt/bootstrap-project.sh

# Copy bootstrap.sh
COPY opt/bootstrap.sh /opt/bootstrap.sh
RUN chmod +x /opt/bootstrap.sh

# Copy directories.sh
COPY opt/directories.sh /opt/directories.sh
RUN chmod +x /opt/directories.sh

# Create data and logs directory and set the correct folder permissions
RUN mkdir /var/www/html_data \
	&& mkdir /var/www/logs

ENTRYPOINT ["/opt/bootstrap.sh"]
