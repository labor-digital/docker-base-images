# TAG: labordigital/docker-base-images:node10-dev
# Build: docker build -t labordigital/docker-base-images:node10-dev .
# Push: docker push labordigital/docker-base-images:node10-dev
FROM labordigital/docker-base-images:node10

# Define author
MAINTAINER LABOR digital <info@labor.digital>

# Set Label
LABEL description="LABOR Digital Node 10 Dev Edition"

ENV NODE_ENV development

# Install some packages we need in dev
RUN apt-get update && apt-get install -y \
		vim \
		nano

# Install some global dependencies
RUN npm i -g nodemon npm-check-updates jest

# Setup a root bashrc for the composer-alias
COPY conf/.bashrc /root/

# Copy bootstrap-dev.sh
COPY opt/bootstrap-dev.sh /opt/bootstrap-dev.sh
RUN chmod +x /opt/bootstrap-dev.sh

# Copy bootstrap.sh
COPY opt/bootstrap.sh /opt/bootstrap.sh
RUN chmod +x /opt/bootstrap.sh

# Copy directories.sh
COPY opt/directories.sh /opt/directories.sh
RUN chmod +x /opt/directories.sh