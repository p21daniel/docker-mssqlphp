FROM php:8.0-fpm-buster

RUN apt-get update && apt-get install -y wget apt-utils gnupg software-properties-common apt-transport-https libcurl4 libzip4 libzip-dev libonig-dev libonig5 libcurl4-gnutls-dev libxml2-dev unixodbc-dev git unzip nano vim

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list

RUN apt-get update && apt-get install --no-install-recommends -y libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng-dev zlib1g-dev libicu-dev g++ unixodbc-dev && ACCEPT_EULA=Y apt-get install --no-install-recommends -y msodbcsql17 mssql-tools && apt-get install --no-install-recommends -y libxml2-dev libaio-dev libmemcached-dev freetds-dev libssl-dev openssl

RUN pecl install sqlsrv pdo_sqlsrv

RUN docker-php-ext-install iconv sockets pdo pdo_mysql curl xml zip intl mbstring gd opcache

RUN docker-php-ext-enable sqlsrv pdo_sqlsrv

RUN pecl install redis

RUN docker-php-ext-enable redis

RUN apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*