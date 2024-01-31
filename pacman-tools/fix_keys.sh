#!/bin/sh

usage() {
    echo -e "Usage : fix-keys [OPTIONS] [KEYS]\n"
    echo "Commands :"
    echo "  -h, --help    : Display this help."
    echo ""
    echo "Options :"
    echo "  -r, --refresh : Refresh the master package database."
    echo ""
    echo "Keys :"
    echo "  -a, --all     : Update all keys."
    echo "      --arch    : Update Arch keys."
    echo "      --artix   : Update Artix keys."
    echo ""
}

fix_keys() {
    sudo pacman-key --init
    sudo pacman-key --populate $1
    sudo pacman -S --noconfirm $1-keyring
}

REFRESH=false

if [ "$#" = 0 ]; then
    usage
    exit 0
fi
while [ "$#" -ne 0 ]; do
    case "$1" in
        -h|--help)
            usage
            exit 0
            ;;
        -r|--refresh)
            REFRESH=true
            shift
            ;;
        -a|--all)
            sudo rm -rf /etc/pacman.d/gnupg /var/lib/pacman/sync
            sudo pacman -Syy
            "$(realpath `dirname $0`)/fix_keys.sh" --artix --arch
            shift
            ;;
        --arch)
            fix_keys "archlinux"
            shift
            ;;
        --artix)
            fix_keys "artix"
            shift
            ;;
        *)
            echo "Error: Unknown option '$1'"
            usage
            exit 1
            ;;
    esac
done

if [ $REFRESH = true ]; then sudo pacman -Syy; fi

exit 0