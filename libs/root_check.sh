#!/bin/bash

must_run_as_root() {
    ROOT_UID=0
    if [ "$UID" != "$ROOT_UID" ]; then
        out_e "Script must be run as root."
        exit 1
    fi
}