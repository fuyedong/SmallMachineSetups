#!/bin/bash

#trim
str_trim() {
    echo "$*" | grep -o "[^ ]\+\( \+[^ ]\+\)*"
}