#!/bin/bash

source ./libs/output.sh
source ./libs/project_dir.sh
source ./libs/root_check.sh

must_run_as_root

if [ ! -e "/usr/local/php/bin/php" ]; then
    out_e "PHP not installed."
    exit 1
fi

if [ -e "/usr/local/php/bin/php" ]; then
    if [ ! -e "/usr/local/bin/php" ]; then
        echo "Making php alias"
        cd /usr/local/bin/
        ln -s /usr/local/php/bin/* .
        cd /usr/local/bin/
        ln -s /usr/local/php/bin/php .
        cd /usr/local/sbin/
        ln -s /usr/local/php/sbin/php-fpm .
    else
        out_n "PHP found under directory /usr/local/bin/"
    fi
else
    out_s "PHP has not installed."
fi

if [ ! -e "/ect/php/php.ini" ]; then
    if [ ! -e "/etc/php" ]; then
        mkdir /etc/php
    fi
    PHP_SRC_DIR=`find /root/src/ -name 'php-5*' -type d`
    cd "$PHP_SRC_DIR"
    if [ ! -e "./php.ini-production" ]; then
        echo "Origin PHP configuration not found."
    else
        cp ./php.ini-production /etc/php/php.ini
    fi
    if [ ! -e "./sapi/fpm/php-fpm.conf" ]; then
        echo "Origin PHP-FPM configuration not found."
    else
        cp ./sapi/fpm/php-fpm.conf /etc/php/php-fpm.conf
    fi
fi

if [ ! -e "/etc/init.d/php-fpm" ]; then
    cd ${PROJECT_DIR}
    if [ ! -e "./assets/php-fpm" ]; then
        echo "Origin php-fpm startup script not found."
    else
        cp ./assets/php-fpm /etc/init.d/php-fpm
        chmod 0755 /etc/init.d/php-fpm
        cd /etc/rc2.d
        ln -s ../init.d/php-fpm S10php-fpm
        cd /etc/rc3.d
        ln -s ../init.d/php-fpm S10php-fpm
        cd /etc/rc4.d
        ln -s ../init.d/php-fpm S10php-fpm
        cd /etc/rc5.d
        ln -s ../init.d/php-fpm S10php-fpm
    fi
fi