#!/bin/sh

check_internet() {
    if ! ping -c 1 -q github.com >/dev/null 2>&1; then
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