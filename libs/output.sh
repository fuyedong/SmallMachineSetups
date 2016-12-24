#!/bin/bash

out_color() {
    echo -e "\E\033[$*\033[0m"
}

#error
out_e() {
    out_color "31m$1"
}

#warning
out_w() {
    out_color "33m$1"
}

#notice
out_n() {
    out_color "34m$1"
}

#debug
out_d() {
    out_color "2m$1"
}

#success
out_s() {
    out_color "32m$1"
}