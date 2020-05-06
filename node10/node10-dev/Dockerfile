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
RUN npm i -g nodemon npm-check-updates

# Setup a root bashrc for the composer-alias
COPY conf/.bashrc-extension /root/

# Inject bootstrap extension
COPY opt/bootstrap-extension.sh /opt/
RUN chmod +x /opt/bootstrap-extension.sh