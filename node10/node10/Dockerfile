# TAG: labordigital/docker-base-images:node10
# Build: docker build -t labordigital/docker-base-images:node10 .
# Push: docker push labordigital/docker-base-images:node10

FROM node:10-buster

# Define author
MAINTAINER LABOR.digital <info@labor.digital>

# Set Label
LABEL description="LABOR Digital Node 10"

# Expose ports
EXPOSE 8000

# Set console to xterm to fix problems with nano and other console comands in pseudo-TTY connections
# @see http://stackoverflow.com/questions/27826241/running-nano-in-docker-container
ENV TERM=xterm

# Install sudo
RUN apt-get update && apt-get install -y sudo

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

ENV NODE_ENV production

# Install curl
RUN apt-get install -y \
		curl \
		libcurl4-gnutls-dev

# Install zip extension
RUN apt-get install -y \
        libzip-dev \
        zip

# Setup a root bashrc for the composer-alias
COPY conf/.bashrc /root/

# Add default index.js
COPY opt/index.js /opt

# Add our entrypoint
COPY opt/bootstrap.sh /opt/bootstrap.sh
RUN chmod +x /opt/bootstrap.sh

# Create data and logs directory and set the correct folder permissions
RUN mkdir -p /var/www/html_data \
	&& chown -R node.node /var/www/html_data \
	&& chmod -R u=rwX,g=rwX,o-rwx /var/www/html_data \
	&& mkdir -p /var/www/logs \
	&& chown -R node.node /var/www/logs \
	&& chmod -R u=rwX,g=rwX,o-rwx /var/www/logs \
	&& mkdir -p /var/www/html \
	&& chown -R node.node /var/www/html \
	&& chmod -R u=rwX,g=rwX,o-rwx /var/www/html

WORKDIR /var/www/html

# Copy default entry point
COPY src/* /var/www/html/

ENTRYPOINT ["/opt/bootstrap.sh"]