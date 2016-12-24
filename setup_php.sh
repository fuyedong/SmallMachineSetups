#!/bin/bash

if [ -e "/usr/local/php/bin/php" ]; then
    if [ !-e "/usr/local/bin/php" ]; then
        echo "Making php alias"
        cd /usr/local/bin/
        sudo ln -s /usr/local/php/bin/* .
        cd /usr/local/bin/
        sudo ln -s /usr/local/php/bin/php .
        cd /usr/local/sbin/
        sudo ln -s /usr/local/php/sbin/php-fpm .
    else
        echo "PHP found under directory /usr/local/bin/"
    fi
else
    echo "PHP has not installed."
fi

if [ ! -e "/ect/php/php.ini" ]; then
    if [ ! -e "/etc/php" ]; then
        sudo mkdir /etc/php
    fi
    PHP_SRC_DIR=`find /root/src/ -name 'php-5*' -type d`
    cd "$PHP_SRC_DIR"
    if [ ! -e "./php.ini-production" ]; then
        echo "Origin PHP configuration not found."
    else
        sudo cp "./php.ini-production /etc/php/php.ini"
    fi
    if [ ! -e "./sapi/fpm/php-fpm.conf" ]; then
        echo "Origin PHP-FPM configuration not found."
    else
        sudo cp "./sapi/fpm/php-fpm.conf /etc/php/php-fpm.conf"
    fi
fi

if [ ! -e "/etc/init.d/php-fpm" ]; then
    cd `dirname $0`
    if [ ! -e "./assets/php-fpm" ]; then
        echo "Origin php-fpm startup script not found."
    else
        sudo cp "./assets/php-fpm /etc/init.d/php-fpm"
        sudo chmod 0755 /etc/init.d/php-fpm
        cd /etc/rc2.d
        sudo ln -s ../init.d/php-fpm S10php-fpm
        cd /etc/rc3.d
        sudo ln -s ../init.d/php-fpm S10php-fpm
        cd /etc/rc4.d
        sudo ln -s ../init.d/php-fpm S10php-fpm
        cd /etc/rc5.d
        sudo ln -s ../init.d/php-fpm S10php-fpm
    fi
fi