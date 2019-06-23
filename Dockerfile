FROM dustinrue/base-php:latest

RUN yum install -y --enablerepo=remi-php${PHP_VERSION} \
  mariadb \
  nc \
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
