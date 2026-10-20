FROM php:8.2-apache

# Set working directory
WORKDIR /var/www

    ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions mbstring pdo_mysql zip exif pcntl gd bcmath


RUN apt-get update && apt-get install -y \
		build-essential \
		locales \
		zip \
		jpegoptim optipng pngquant gifsicle \
		vim \
		unzip \
		git \
		curl \
		libfreetype-dev \
		libjpeg62-turbo-dev \
		libpng-dev

RUN apt-get clean && rm -rf /var/lib/apt/lists/*


#RUN docker-php-ext-install pdo pdo_mysql
#RUN docker-php-ext-install mbstring
#RUN docker-php-ext-install exif
#RUN docker-php-ext-install pcntl
#RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-png
#RUN docker-php-ext-install -j$(nproc) gd
#RUN docker-php-ext-install bcmath

