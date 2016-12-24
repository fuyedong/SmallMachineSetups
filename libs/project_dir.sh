#!/bin/bash

if [ "$PROJECT_DIR" == "" ]; then
    PROJECT_DIR=`dirname $(readlink -f "$0")`
fi