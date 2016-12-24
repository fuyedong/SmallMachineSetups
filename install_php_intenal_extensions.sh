#!/bin/bash

source ./libs/output.sh
source ./libs/root_check.sh
source ./libs/string.sh

must_run_as_root

if [ "$*" == "" ]; then
    out_e "Please input at least one extension name"
    exit 1
fi

php_internal_extension_install() {
    pe_e=`php -m | grep "$1" | xargs`
    PHP_SRC_DIR=`find /root/src/ -name 'php-5*' -type d`
    if [ "$PHP_SRC_DIR" != "" ]; then
        cd "${PHP_SRC_DIR}/ext/"
    else
        out_n "PHP source directory not found."
    fi
    if [ "$pe_e" == "$1" ]; then
        echo "existed."
    elif [ ! -e "./$1" ]; then
        out_w "$1 is not an internal php extension."
    else
        echo -n "Installing $1: "
        cd "./$1"
        phpize
        ./configure
        make && make install
        if [ "$?" == "0" ];then
            echo "
[$1]
extension=$1.so" >> /etc/php/php.ini
        fi
        echo "OK."
    fi
}

for php_extension in `str_trim $*`; do
    php_internal_extension_install ${php_extension}
done