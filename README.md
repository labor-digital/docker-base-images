# LABOR.digital - PHP 7.3 Base Image

A base image for PHP 7.3 with a bunch of extensions already preconfigured.

Note: As we are a company based in germany the locale and timezone are already preconfigured for germany!

## Environment Variables
All environment variables that are inherited from the base image ([here](https://hub.docker.com/_/php))

- PROJECT_ENV ("prod") Helper to define the environment for your application. SHOULD BE "dev", "staging" or "prod";
- APACHE_WEBROOT ("/var/www/html") Defines the apache webroot directory

## Variants
This is a mono-repository that holds multiple variants of the same base image.
Every directory holds the configuration for a single variant.

- php73: ```labordigital/docker-base-images:php73``` 
    The root PHP image the other variants inherit from
- php73-dev: ```abordigital/docker-base-images:php73-dev```
    The base image with additional helpers for the development environment like composer already installed.
- php73-ext: ```labordigital/docker-base-images:php73-ext```
    The base image with imagick, SOAP and poppler-utils (PDF-to-text) already pre-installed
- php73-ext-dev: ```labordigital/docker-base-images:php73-ext-dev```
    The extended base image with additional helpers for the development environment

## Boilerplate
In the "boilerplate" directory you will find a basic project implementation using the images

**A word of caution**: When you checkout the boilerplate make sure all .sh files have the "LF" line endings selected (GIT tends to convert them to CRLF on windows machines).


## Postcardware
You're free to use these images, but if it makes it to your production environment we highly appreciate you sending us a postcard from your hometown, mentioning which of our package(s) you are using.

Our address is: LABOR.digital - Fischtorplatz 21 - 55116 Mainz, Germany

We publish all received postcards on our [company website](https://labor.digital).