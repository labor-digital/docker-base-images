ARG DOCKER_BASE_IMAGE
ARG DOCKER_BASE_TAG

FROM ${DOCKER_BASE_IMAGE}:${DOCKER_BASE_TAG}

# You can pass the apache webroot as a build argument -> otherwise we will use /var/www/html as a default
ARG APACHE_WEBROOT

# @todo Add your maintainer here!
MAINTAINER LABOR.digital <info@labor.digital>

# Add our sources
ADD src/. /var/www/html

# Add and run our additional shell scripts
COPY opt/build_and_bootstrap-dir.sh /opt/build_and_bootstrap-dir.sh
RUN chmod +x /opt/build_and_bootstrap-dir.sh && /opt/build_and_bootstrap-dir.sh
COPY opt/build_and_bootstrap-env.sh /opt/build_and_bootstrap-env.sh
RUN chmod +x /opt/build_and_bootstrap-env.sh && /opt/build_and_bootstrap-env.sh
COPY opt/bootstrap-project.sh /opt/bootstrap-project.sh
RUN chmod +x /opt/bootstrap-project.sh
