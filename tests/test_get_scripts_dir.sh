#!/bin/bash

source ../libs/output.sh
source ../libs/project_dir.sh

cd /usr/local/bin
if [ "$(dirname $(readlink -f $0))" != ${PROJECT_DIR} ]; then
    out_s "PASS."
else
    out_e "FAILED."
fi
if [ `pwd` != ${PROJECT_DIR} ]; then
    out_s "PASS."
else
    out_e "FAILED."
fi