FROM centos:7

ARG PHP_VERSION=73

RUN yum upgrade -y
RUN yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum install -y --enablerepo=remi-php${PHP_VERSION} \
  php-common \
  php-xmlrpc \
  php-pecl-memcached \
  php-pecl-memcache \
  php-mysqlnd \
  php-pear \
  php-gd \
  php-mbstring \
  php-cli \
  php-process \
  php-opcache \
  php-pecl-redis \
  php-bcmath \
  php-pecl-gearman \
  php-soap \
  php-devel \
  php-zip \
  ImageMagick \
  ImageMagick-devel \
  php-pecl-imagick \
  mariadb-client \
  wget \
  git \
  unzip

COPY scripts/composer-installer.sh /composer-installer.sh
RUN sh /composer-installer.sh && mv /composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer
RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp
RUN composer global require 10up/wpsnapshots
ENV PATH="~/.composer/vendor/bin:${PATH}"

WORKDIR /var/www/html

CMD ["php"]
