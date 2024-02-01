#!/bin/sh

cd `realpath $(dirname $0)` || exit 1
. check_status.sh

usage() {
    printf "Usage : fix-keys [OPTIONS] [KEYS]\n\n"
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
    check_internet
    check_sudo

    sudo pacman-key --init
    sudo pacman-key --populate $1
    sudo pacman -S --noconfirm $1-keyring

    printf "\nSuccess to fix $1 keys\n"
}

if [ "$#" = 0 ]; then
    usage
    exit 0
fi
while [ "$#" != 0 ]; do
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
            check_internet
            check_sudo

            sudo rm -rf /etc/pacman.d/gnupg /var/lib/pacman/sync
            sudo pacman -Syy
            ./fix_keys.sh --artix --arch

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

[ ! "$REFRESH" ] || sudo pacman -Syy

exit 0