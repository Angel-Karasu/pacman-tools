#!/bin/sh

. /etc/os-release
. ./pactools.sh >/dev/null

sudo sed -i '/# Start commands/,/# End commands/{//!d}' ./pactools.sh
add_in_pactools () { sudo sed -i "/# End commands/i\ \t\t$1" ./pactools.sh; }

add_in_update_mirrrors() { add_in_pactools "update_mirror_list '$1' '$2' '$3'"; }

add_arch() { add_in_update_mirrrors "https://archlinux.org/mirrorlist/?country=all&protocol=https&use_mirror_status=on" mirrorlist$1; }

[ "`pacman -T chaotic-mirrorlist`" ] || add_in_update_mirrrors "https://aur.chaotic.cx/mirrorlist.txt" chaotic-mirrorlist;

case $ID in
    arch|archcraft|garuda)
        add_arch;;
    artix)
        add_in_update_mirrrors "https://gitea.artixlinux.org/packages/artix-mirrorlist/raw/branch/master/mirrorlist" mirrorlist
        [ "`pacman -T archlinux-mirrorlist`" ] || add_arch -arch
        ;;
    endeavouros)
        add_in_update_mirrrors "https://gitlab.com/endeavouros-filemirror/PKGBUILDS/-/raw/master/endeavouros-mirrorlist/endeavouros-mirrorlist" endeavouros-mirrorlist
        add_arch
        ;;
    manjaro)
        add_in_update_mirrrors "https://repo.manjaro.org/mirrors.json" mirrorlist 'stable/$repo/$arch';;
    rebornos)
        add_in_update_mirrrors "https://raw.githubusercontent.com/RebornOS-Team/rebornos-mirrorlist/main/reborn-mirrorlist" reborn-mirrorlist
        add_arch
        ;;
    *)
        echo "$ID is not compatible."
        exit 1
        ;;
esac

add_in_pactools 'sudo pacman -Syy'

exit 0
