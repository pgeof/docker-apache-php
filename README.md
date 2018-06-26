# apache-php

Docker image based on Ubuntu that embeds apache 2.4 server and PHP

## Supported tags

* 7.2, latest (ubuntu bionic)
* 7.1 (ubuntu xenial)
* 7.0 (ubuntu xenial)
* 5.6 (ubuntu xenial)

## Installation

### PHP extensions installed

* pdo
* pdo-mysql
* gd
* mbstring
* xml
* pear
* zip
* intl
* curl
* soap

### Pear extensions installed

* Mail
* Mail_Mime
* Net_SMTP

### Apache modules enabled

* ssl
* rewrite
* [mod_xsendfile](https://tn123.org/mod_xsendfile/)

### Other tools installed

* [composer](https://getcomposer.org/) (executable name is `composer.phar`)
* zip / unzip
* git

## Configuration

### Exposed ports  

* 80

### Apache DocumentRoot

By default apache DocumentRoot is configured to `/var/www` folder.

### Apache sites configuration

Apache sites are configured in folder `/etc/apache2/sites-enabled`.

## Usages

```sh
    docker run -d -v /your_site_base_folder:/var/www -p 80:80 pgeof/apache-php
```

Start an apache webserver available on TCP port 80 on your machine. The document root folder is the one you specify after the `-v` parameter.

```sh
    docker run -d -v /your_site_base_folder:/var/www -v /your_apache_site_config:/etc/apache2/sites-enabled -p 80:80 pgeof/apache-php
```

Same command as previous, but this time apache sites configuration must be defined in the folder you specify after the second `-v` parameter.