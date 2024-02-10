#!/bin/sh

. /etc/os-release
. ./pactools.sh >/dev/null

sudo sed -i '/# Start commands/,/# End commands/{//!d}' ./pactools.sh
add_in_pactools () { sudo sed -i "/# End commands/i\ \t$1" ./pactools.sh; }

add_in_update_mirrrors() { add_in_pactools "update_mirror_list '$1' '$2mirrorlist' '$3'"; }

add_arch() { add_in_update_mirrrors "https://archlinux.org/mirrorlist/?country=all&protocol=https&use_mirror_status=on"; }

case $ID in
    artix)
        add_in_update_mirrrors "https://gitea.artixlinux.org/packages/artix-mirrorlist/raw/branch/master/mirrorlist" mirrorlist
        [ "`pacman -T archlinux-mirrorlist`" ] || add_arch -arch
        ;;
esac

# Sort by number of https server
[ "`pacman -T rebornos-mirrorlist`" ] || add_in_update_mirrrors "https://raw.githubusercontent.com/RebornOS-Team/rebornos-mirrorlist/main/reborn-mirrorlist" reborn-;
[ "`pacman -T arcolinux-mirrorlist-git`" ] || add_in_update_mirrrors "https://raw.githubusercontent.com/arcolinux/arcolinux-mirrorlist/master/etc/pacman.d/arcolinux-mirrorlist" arcolinux-;
[ "`pacman -T endeavouros-mirrorlist`" ] || add_in_update_mirrrors "https://gitlab.com/endeavouros-filemirror/PKGBUILDS/-/raw/master/endeavouros-mirrorlist/endeavouros-mirrorlist" endeavouros-;
[ "`pacman -T chaotic-mirrorlist`" ] || add_in_update_mirrrors "https://aur.chaotic.cx/mirrorlist.txt" chaotic-;
[ "`pacman -T blackarch-mirrorlist`" ] || add_in_update_mirrrors "https://raw.githubusercontent.com/BlackArch/blackarch-site/master/blackarch-mirrorlist" blackarch-;
[ "`pacman -T pacman-mirrors`" ] || add_in_update_mirrrors "https://repo.manjaro.org/mirrors.json" '' 'stable/$repo/$arch';
[ "`pacman -T pacman-mirrorlist`" ] || add_arch;

add_in_pactools 'sudo pacman -Syy'