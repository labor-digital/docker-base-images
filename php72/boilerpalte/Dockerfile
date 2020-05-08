ARG DOCKER_BASE_IMAGE
ARG DOCKER_BASE_TAG

# ===================================================
# Install composer dependencies
# ===================================================

# Uncomment this to use a multi-step build to install your composer
# dependencies while building your production image

#FROM ${DOCKER_BASE_IMAGE}:${DOCKER_BASE_TAG}-dev
#
## Add and run our additional shell scripts
#COPY opt /opt
#RUN find /opt/ -type f -iname "*.sh" -exec chmod +x {} \;
#
## Prepare build environment
#ADD src/ /var/www/html/
#RUN source /root/.bashrc \
#	&& chown -R "$DEFAULT_OWNER" /var/www/html
#RUN ls -la /var/www/html
#RUN /opt/dev/prepare-build-env.sh
#
#RUN ls -la /var/www/html
#
## Run composer install
#RUN source /root/.bashrc \
#	&& composer install

# ===================================================
# Build Project Image
# ===================================================
FROM ${DOCKER_BASE_IMAGE}:${DOCKER_BASE_TAG}

# You can pass the apache webroot as a build argument -> otherwise we will use /var/www/html as a default
ARG APACHE_WEBROOT

# @todo Add your maintainer here!
MAINTAINER LABOR.digital <info@labor.digital>

# Add our sources
# Comment out the "ADD" line and uncomment the "COPY" line when you want to use the multi-step build
ADD src/. /var/www/html
#COPY --from=0 /var/www/html/vendor /var/www/html

# Add and run our additional shell scripts
COPY opt/build_and_bootstrap-dir.sh /opt/build_and_bootstrap-dir.sh
RUN chmod +x /opt/build_and_bootstrap-dir.sh
COPY opt/build_and_bootstrap-env.sh /opt/build_and_bootstrap-env.sh
RUN chmod +x /opt/build_and_bootstrap-env.sh
COPY opt/bootstrap-project.sh /opt/bootstrap-project.sh
RUN chmod +x /opt/bootstrap-project.sh

# Run our build script
RUN /opt/build.sh

ENV APACHE_WEBROOT=${APACHE_WEBROOT}