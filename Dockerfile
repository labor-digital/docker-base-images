# TAG: labordigital/docker-base-images:php73-dev
# Build: docker build -t labordigital/docker-base-images:php73-dev .
# Push: docker push labordigital/docker-base-images:php73-dev
FROM labordigital/docker-base-images:php73

# Define author
MAINTAINER LABOR digital <info@labor.digital>

# Set Label
LABEL description="Labor Digital PHP7.3 Dev Edition"

# Install some packages we need in dev
RUN apt-get update && apt-get install -y \
		vim \
		nano \
		mariadb-client \
		git

# Add an extension to the bashrc to register the composer alias
COPY conf/.bashrc-extension /root/

# Add development configuration
COPY /conf/99-environment.ini /usr/local/etc/php/conf.d/

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin

# Install dev symlinker
RUN /usr/local/bin/composer.phar global require labor-digital/composer-dev-symlink

# Inject bootstrap extension
COPY opt/bootstrap-extension.sh /opt/bootstrap-extension.sh
RUN chmod +x /opt/bootstrap-extension.sh
