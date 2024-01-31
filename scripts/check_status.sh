#!/bin/sh

check_internet() {
    if [ $(ping -c 1 -q github.com >&/dev/null; echo $?) != 0 ]; then
        echo "Error: No Internet connection"
        exit 1
    fi
}
check_sudo() {
    if ! sudo -v; then
        echo "Root privileges denied";
        exit 1
    fi
}