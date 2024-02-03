#!/bin/sh

usage() {
    printf "Usage : update-mirrors [OPTIONS] [MIRRORS]\n\n"
    echo "Commands :"
    echo "  -h, --help    : Display this help."
    echo ""
    echo "Options :"
    echo "  -q, --quiet   : Quiet mode."
    echo "  -r, --refresh : Refresh the master package database."
    echo ""
}

update_mirror_list() {
    . /etc/os-release

    file=/etc/pacman.d/mirrorlist`[ $ID = $1 ] || echo -$1`

    if [ "$QUIET" ]; then
        curl -s $2 | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -w -n 6 - | sudo tee $file >/dev/null
    else
        curl -s $2 | sed 's/#Server/Server/' | rankmirrors -w -n 6 - | sudo tee $file && sudo sed -i '/^#/d' $file
        printf "\nSuccess to update $1 mirrors\n"
    fi
}

while [ "$#" != 0 ]; do
    case "$1" in
        -h|--help)
            usage
            exit 0
            ;;
        -q|--quiet)
            QUIET=true
            q=-q
            shift
            ;;
        -r|--refresh)
            REFRESH=true
            shift
            ;;
        *)
            echo "Error: Unknown option '$1'"
            usage
            exit 1
            ;;
    esac
done
