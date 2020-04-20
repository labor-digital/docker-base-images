# TAG: labordigital/docker-base-images:php53-dev
# Build: docker build -t labordigital/docker-base-images:php53-dev .
# Push: docker push labordigital/docker-base-images:php53-dev
FROM labordigital/docker-base-images:php53

# Define author
MAINTAINER LABOR digital <info@labor.digital>

# Set Label
LABEL description="Labor Digital PHP5.3 Dev Edition"

# Install some packages we need in dev
RUN apt-get update && apt-get install -y \
		vim \
		nano \
		mariadb-client \
		git

# Setup a composer user
RUN groupadd composer
RUN adduser composer --disabled-login --disabled-password --home /home/composer --ingroup composer --gecos ""
RUN usermod -a -G www-data composer

# Setup a root bashrc for the composer-alias
COPY conf/.bashrc /root/

# Add development configuration
COPY /conf/99-environment.ini /usr/local/etc/php/conf.d/

# Copy bootstrap-dev.sh
COPY opt/bootstrap-dev.sh /opt/bootstrap-dev.sh
RUN chmod +x /opt/bootstrap-dev.sh

# Copy bootstrap.sh
COPY opt/bootstrap.sh /opt/bootstrap.sh
RUN chmod +x /opt/bootstrap.sh

# Copy directories.sh
COPY opt/directories.sh /opt/directories.sh
RUN chmod +x /opt/directories.sh