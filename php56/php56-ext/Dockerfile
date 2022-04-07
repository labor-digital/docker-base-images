# TAG: labordigital/docker-base-images:php56-ext
# Build: docker build -t labordigital/docker-base-images:php56-ext .
# Push: docker push labordigital/docker-base-images:php56-ext

FROM labordigital/docker-base-images:php56

# Define author
MAINTAINER LABOR.digital <info@labor.digital>

# Set Label
LABEL description="LABOR Digital PHP5.6 - Extended"

# Run additional library installation
COPY opt /opt
RUN chmod +x /opt/ext/build.sh
RUN /opt/ext/build.sh