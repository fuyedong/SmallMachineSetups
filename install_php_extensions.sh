#!/bin/bash

php_extension_install() {
    ext_name="php_$1"
    echo -n "Installing $ext_name"
    if [ "$(php -m | grep $1 | xargs)"=="$1" ]; then
        echo "existed."
    else
        echo "OK."
        cd /root/src
        wget $2
        tar xzf $2
        cd $3
        phpize
        ./configure
        make && make install
        echo "[$1]
extension=$ext_name"
    fi
}

php_extension_install memcached http://pecl.php.net/get/memcached-2.1.0.tgz memcached-2.1.0/
php_extension_install redis http://pecl.php.net/get/redis-2.2.8.tgz redis-2.2.8/
php_extension_install solr http://pecl.php.net/get/solr-2.4.0.tgz solr-2.4.0/