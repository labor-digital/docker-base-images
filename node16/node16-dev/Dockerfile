ARG BASE_TAG

FROM labordigital/docker-base-images:${BASE_TAG}

MAINTAINER LABOR digital <info@labor.digital>
LABEL description="Labor Digital ${BASE_TAG} Dev Edition"

COPY ssl/localmachine.space/localmachine.space.merged.crt /var/cert/merged.crt

ENV NODE_ENV development

# Install some global dependencies
RUN npm i -g nodemon npm-check-updates

# Add an extension to the bashrc to register the composer alias
COPY conf/bashrc-dev.sh /root/
RUN chmod +x /root/bashrc-dev.sh

# Add our additional scripts
COPY opt /opt
RUN find /opt/dev -type f -iname "*.sh" -exec chmod +x {} \;

ENV WRITE_PERMISSION_MARKERS=1
