#!/bin/sh

. /etc/os-release
. ./pactools.sh >/dev/null

sudo sed -i '/# Start commands/,/# End commands/{//!d}' ./pactools.sh
add_in_pactools () { sudo sed -i "/# End commands/i\ \t$1" ./pactools.sh; }

add_in_update_mirrrors() { add_in_pactools "update_mirror_list '$1' '$2' '$3'"; }

add_arch() { add_in_update_mirrrors "https://archlinux.org/mirrorlist/?country=all&protocol=https&use_mirror_status=on" mirrorlist$1; }
add_distrib_and_arch() {
    add_in_update_mirrrors "$1" $2-mirrorlist
    add_arch
}

case $ID in
    arch|archcraft|garuda)
        add_arch;;
    arcolinux)
        add_distrib_and_arch "https://raw.githubusercontent.com/arcolinux/arcolinux-mirrorlist/master/etc/pacman.d/arcolinux-mirrorlist" arcolinux;;
    artix)
        add_in_update_mirrrors "https://gitea.artixlinux.org/packages/artix-mirrorlist/raw/branch/master/mirrorlist" mirrorlist
        [ "`pacman -T archlinux-mirrorlist`" ] || add_arch -arch
        ;;
    blackarch|athena)
        add_distrib_and_arch "https://raw.githubusercontent.com/BlackArch/blackarch-site/master/blackarch-mirrorlist" blackarch;;
    endeavouros)
        add_distrib_and_arch "https://gitlab.com/endeavouros-filemirror/PKGBUILDS/-/raw/master/endeavouros-mirrorlist/endeavouros-mirrorlist" endeavouros;;
    rebornos)
        add_distrib_and_arch "https://raw.githubusercontent.com/RebornOS-Team/rebornos-mirrorlist/main/reborn-mirrorlist" reborn;;
esac

# Sort by number of https server
[ "`pacman -T chaotic-mirrorlist`" ] || add_in_update_mirrrors "https://aur.chaotic.cx/mirrorlist.txt" chaotic-mirrorlist;
[ "`pacman -T pacman-mirrors`" ] || add_in_update_mirrrors "https://repo.manjaro.org/mirrors.json" mirrorlist 'stable/$repo/$arch';

add_in_pactools 'sudo pacman -Syy'