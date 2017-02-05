#!/bin/bash

source ./libs/output.sh
source ./libs/root_check.sh

must_run_as_root

php_extension_install() {
    file_name=`basename $2`
    echo -n "Installing $1: "
    p_e_e=`php -m | grep "$1" | xargs`
    if [ $p_e_e == "$1" ]; then
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
        echo "
[$1]
extension=$1.so" >> /etc/php/php.ini
    fi
}
php_extension_install memcached http://pecl.php.net/get/memcached-2.1.0.tgz memcached-2.1.0/
php_extension_install redis http://pecl.php.net/get/redis-2.2.8.tgz redis-2.2.8/
php_extension_install solr http://pecl.php.net/get/solr-2.4.0.tgz solr-2.4.0/
php_extension_install swoole https://pecl.php.net/get/swoole-1.9.3.tgz swoole-1.9.3/


echo -n "Installing phalcon: "
pe_src="https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.13.tar.gz"
pe_name=`basename $pe_src`
pe_exists=`php -m | grep phalcon | xargs`
if [ $pe_exists == "phalcon" ]; then
    echo "existed."
else
    cd /root/src
    if [ ! -e $pe_name ]; then
        wget $pe_src
    fi
    tar xzf ${pe_name}
    cd cphalcon-phalcon-v2.0.13/build/
    ./install
    if [ "$?" == "0" ];then
        echo "
[Phalcon]
extension=phalcon.so" >> /etc/php/php.ini
        echo "OK."
    else
        echo "Failed."
    fi
fi
