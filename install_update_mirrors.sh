#!/bin/sh

. /etc/os-release
. ./pactools.sh >/dev/null

sed -i '/# Start commands/,/# End commands/{//!d}' ./pactools.sh
add_in_pactools () { sed -i "/# End commands/i\ \t\t$1" ./pactools.sh; }

add_in_update_mirrrors() { add_in_pactools "update_mirror_list '$1' '$2'"; }

add_arch() { add_in_update_mirrrors "https://archlinux.org/mirrorlist/?country=all&protocol=https&use_mirror_status=on" mirrorlist$1; }

check_package() {
    if ! pacman -T $1 >/dev/null; then
        check_internet
        echo " - Install $1"
        sudo pacman -S --noconfirm $1
    fi
}

case $ID in
    arch)
        add_arch;;
    artix)
        add_in_update_mirrrors "https://gitea.artixlinux.org/packages/artix-mirrorlist/raw/branch/master/mirrorlist" mirrorlist
        [ "`pacman -T archlinux-mirrorlist`" ] || add_arch -arch
        ;;
    endeavouros)
        add_in_update_mirrrors "https://gitlab.com/endeavouros-filemirror/PKGBUILDS/-/raw/master/endeavouros-mirrorlist/endeavouros-mirrorlist" endeavouros-mirrorlist
        add_arch
        ;;
    garuda)
        add_in_update_mirrrors "https://aur.chaotic.cx/mirrorlist.txt" chaotic-mirrorlist
        add_arch
        ;;
    manjaro)
        check_package pacman-mirrors
        echo 'sudo pacman-mirrors --fasttrack 6' | sudo tee -a update_mirrors.sh >/dev/null
        ;;
    *)
        echo "$ID is not compatible."
        exit 1
        ;;
esac

add_in_pactools 'sudo pacman -Syy'

exit 0