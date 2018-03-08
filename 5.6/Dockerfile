FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive

COPY res/mod_xsendfile.c /tmp/mod_xsendfile.c

# Add ondrej/php PPA, install php 5.6 and apache module mod_xsendfile
# Zip, Unzip, git and php-xml are necessary for composer and pear package installation

RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com E5267A6C && \
    echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial main" > /etc/apt/sources.list.d/ondrej.php.list && \
    echo "deb-src http://ppa.launchpad.net/ondrej/php/ubuntu xenial main" >> /etc/apt/sources.list.d/ondrej.php.list && \
    apt-get update && \
    apt-get install -y php5.6 php5.6-pdo php5.6-pdo-mysql php5.6-gd php5.6-mbstring php5.6-xml php5.6-zip php5.6-intl php5.6-curl ca-certificates zip unzip git apache2-dev nano && \
    cd /tmp && apxs -cia mod_xsendfile.c && rm -f /tmp/mod_xsendfile* && \
    apt-get -y purge apache2-dev && \
    apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === trim(file_get_contents('https://composer.github.io/installer.sig'))) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir="/usr/bin" && \
    php -r "unlink('composer-setup.php');"

# Install pear
RUN php -r "copy('https://pear.php.net/go-pear.phar', 'go-pear.phar');" && \
    php go-pear.phar && \
    php -r "unlink('go-pear.phar');"

# Upgrade mail pear packages
RUN pear upgrade Mail_Mime && \
    pear upgrade Net_SMTP && \
    pear upgrade Mail && \
    pear clear-cache

COPY res/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY res/docker-pear.ini /etc/php/5.6/mods-available/docker-pear.ini

# Enable Apache and PHP modules
RUN phpenmod docker-pear && a2enmod rewrite ssl && a2ensite 000-default

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid
ENV DEBIAN_FRONTEND dialog

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]