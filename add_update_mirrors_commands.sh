#!/bin/sh

. /etc/os-release

sudo sed -i '/# Start commands/,/# End commands/{//!d}' ./pactools.sh
add_in_pactools () { sudo sed -i "/# End commands/i\ \t$1" ./pactools.sh; }

add_in_update_mirrrors() { add_in_pactools "update_mirror_list '$1' '$2' '$3' '$4'"; }

add_mirrorlist() { [ "`pacman -T $1`" ] || add_in_update_mirrrors $2 $3 `[ "$4" ] && echo $4 || echo $1` $5; }

add_arch_mirrorlist() { add_mirrorlist "$1" "https://archlinux.org/mirrorlist/?country=all&protocol=https&use_mirror_status=on" core "$2mirrorlist"; }
add_cachyos_mirrorlist() { add_mirrorlist "cachyos$1-mirrorlist" "https://raw.githubusercontent.com/CachyOS/CachyOS-PKGBUILDS/master/cachyos$1-mirrorlist/cachyos$1-mirrorlist" "cachyos$1"; }
add_pacman_mirrorlist() { add_mirrorlist 'pacman-mirrorlist' $1 $2 'mirrorlist' $3; }

add_mirrorlist 'rebornos-mirrorlist' 'https://raw.githubusercontent.com/RebornOS-Team/rebornos-mirrorlist/main/reborn-mirrorlist' 'Reborn-OS' 'reborn-mirrorlist';
for v in "" "-v3" "-v4"; do add_cachyos_mirrorlist $v; done;
add_mirrorlist 'arcolinux-mirrorlist-git' 'https://raw.githubusercontent.com/arcolinux/arcolinux-mirrorlist/master/etc/pacman.d/arcolinux-mirrorlist' 'arcolinux_repo' 'arcolinux-mirrorlist';
add_mirrorlist 'endeavouros-mirrorlist' 'https://gitlab.com/endeavouros-filemirror/PKGBUILDS/-/raw/master/endeavouros-mirrorlist/endeavouros-mirrorlist' endeavouros;
add_mirrorlist 'blackarch-mirrorlist' 'https://raw.githubusercontent.com/BlackArch/blackarch-site/master/blackarch-mirrorlist' blackarch;
case $ID in
    artix) add_pacman_mirrorlist 'https://gitea.artixlinux.org/packages/artix-mirrorlist/raw/branch/master/mirrorlist' system;;
    hyperbola) add_pacman_mirrorlist 'https://www.hyperbola.info/mirrorlist/?country=all&protocol=https&use_mirror_status=on' core;;
    kaos) add_pacman_mirrorlist 'https://raw.githubusercontent.com/KaOSx/core/master/pacman-mirrorlist/mirrorlist' core;;
    manjaro) add_pacman_mirrorlist 'https://repo.manjaro.org/mirrors.json' core 'stable/$repo/$arch';;
    parabola) add_pacman_mirrorlist 'https://www.parabola.nu/mirrorlist/?country=all&protocol=https&use_mirror_status=on' core;;
    *) add_arch_mirrorlist 'pacman-mirrorlist';;
esac
add_arch_mirrorlist 'archlinux-mirrorlist' archlinux-;

add_in_pactools 'sudo pacman -Syy'
