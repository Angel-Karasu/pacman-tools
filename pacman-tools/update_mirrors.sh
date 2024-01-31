#!/bin/sh

usage() {
    echo -e "Usage : update-mirrors [OPTIONS] [MIRRORS]\n"
    echo "Commands :"
    echo "  -h, --help    : Display this help."
    echo ""
    echo "Options :"
    echo "  -b, --backup  : Create a backup of the old mirrorlist file."
    echo "  -r, --refresh : Refresh the master package database."
    echo "  -v, --verbose : Verbose mode."
    echo ""
    echo "Mirrors :"
    echo "  -a, --all     : Update all Linux mirrors."
    echo "      --arch    : Update Arch Linux mirrors."
    echo "      --artix   : Update Artix Linux mirrors."
    echo ""
}

update_mirror_list() {
    file=/etc/pacman.d/mirrorlist$([[ $(cat /etc/os-release | sed -e "/$1/b" -e d) ]] && echo '' || echo -$1)
    if [ $BACKUP = false ]; then sudo cp $file $file.backup; fi

    if [ $VERBOSE = true ]; then
        curl -s $2 | sed 's/#Server/Server/' | rankmirrors -w -n 6 - | sudo tee $file && sudo sed -i '/^#/d' $file;
    else curl -s $2 | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -w -n 6 - | sudo tee $file; fi
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
        -b|--backup)
            BACKUP=true
            b=-b
            shift
            ;;
        -r|--refresh)
            REFRESH=true
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            v=-v
            shift
            ;;
        -a|--all)
            exec $(realpath `dirname $0`)/update_mirrors.sh $b $v --arch --artix
            shift
            ;;
        --arch)
            update_mirror_list "arch" "https://archlinux.org/mirrorlist/?country=all&protocol=https"
            shift
            ;;
        --artix)
            update_mirror_list "artix" "https://gitea.artixlinux.org/packages/artix-mirrorlist/raw/branch/master/mirrorlist"
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