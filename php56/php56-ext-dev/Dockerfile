# TAG: labordigital/docker-base-images:php56-ext-dev
# Build: docker build -t labordigital/docker-base-images:php56-ext-dev .
# Push: docker push labordigital/docker-base-images:php56-ext-dev

FROM labordigital/docker-base-images:php56-ext

FROM labordigital/docker-base-images:php56-dev

# Define author
MAINTAINER LABOR.digital <info@labor.digital>

# Set Label
LABEL description="LABOR Digital PHP5.6 Dev Edition - Extended"

# Run additional library installation
COPY --from=0 /opt/ext/build.sh /opt/ext/build.sh
RUN chmod +x /opt/ext/build.sh
RUN /opt/ext/build.sh