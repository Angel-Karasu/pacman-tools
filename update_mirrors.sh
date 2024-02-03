#!/bin/sh

usage() {
    printf "Usage : update-mirrors [OPTIONS] [MIRRORS]\n\n"
    echo "Commands :"
    echo "  -h, --help    : Display this help."
    echo ""
    echo "Options :"
    echo "  -b, --backup  : Create a backup of the old mirrorlist file."
    echo "  -r, --refresh : Refresh the master package database."
    echo "  -v, --verbose : Verbose mode."
    echo ""
}

update_mirror_list() {
    . /etc/os-release

    file=/etc/pacman.d/mirrorlist`[ $ID = $1 ] || echo -$1`
    [ "$BACKUP" ] && sudo cp $file $file.backup

    if [ "$VERBOSE" ]; then
        curl -s $2 | sed 's/#Server/Server/' | rankmirrors -w -n 6 - | sudo tee $file && sudo sed -i '/^#/d' $file
        [ "$REFRESH" ] && sudo pacman -Syy

        printf "\nSuccess to update $1 mirrors\n"
    else
        curl -s $2 | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -w -n 6 - | sudo tee $file >/dev/null;
        [ "$REFRESH" ] && sudo pacman -Syy >/dev/null 2>&1
    fi
}

while [ "$#" != 0 ]; do
    case "$1" in
        -h|--help)
            usage
            exit 0
            ;;
        -b|--backup)
            BACKUP=true
            shift
            ;;
        -r|--refresh)
            REFRESH=true
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        *)
            echo "Error: Unknown option '$1'"
            usage
            exit 1
            ;;
    esac
done
