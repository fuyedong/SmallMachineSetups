#!/bin/sh

./configure --user=www --group=www --prefix=/usr/local/nginx --conf-path=/etc/nginx/nginx.conf --pid-path=/var/run/nginx.pid --with-http_stub_status_module --with-http_ssl_module --with-http_v2_module
