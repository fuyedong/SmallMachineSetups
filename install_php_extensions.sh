#!/bin/bash

source ./libs/output.sh
source ./libs/root_check.sh

must_run_as_root

php_extension_install() {
    ext_name="php_$1"
    file_name=`basename $2`
    echo -n "Installing $ext_name: "
    r=`php -m | grep "$1" | xargs`
    if [ $r == "$1" ]; then
        echo "existed."
    else
        echo "OK."
        cd /root/src
        if [ ! -e ${file_name} ]; then
            wget $2
        fi
        tar xzf ${file_name}
        cd $3
        phpize
        ./configure
        make && make install
        echo "[$1]
extension=$ext_name" >> /etc/php/php.ini
    fi
}
php_extension_install memcached http://pecl.php.net/get/memcached-2.1.0.tgz memcached-2.1.0/
php_extension_install redis http://pecl.php.net/get/redis-2.2.8.tgz redis-2.2.8/
php_extension_install solr http://pecl.php.net/get/solr-2.4.0.tgz solr-2.4.0/