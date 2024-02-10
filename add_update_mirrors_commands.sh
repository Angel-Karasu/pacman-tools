#!/bin/sh

. /etc/os-release
. ./pactools.sh >/dev/null

sudo sed -i '/# Start commands/,/# End commands/{//!d}' ./pactools.sh
add_in_pactools () { sudo sed -i "/# End commands/i\ \t$1" ./pactools.sh; }

add_in_update_mirrrors() { add_in_pactools "update_mirror_list '$1' '$2' '$3'"; }

add_mirrorlist() { [ "`pacman -T $1`" ] || add_in_update_mirrrors $2 `[ "$3" ] && echo $3 || echo $1` $4; }

add_arch_mirrorlist() { add_mirrorlist "$1" 'https://archlinux.org/mirrorlist/?country=all&protocol=https&use_mirror_status=on' "$2mirrorlist"; }

# Sort by number of https server
add_mirrorlist 'archman-mirrorlist' 'https://gitlab.com/Archman-OS/archman-mirrorlist/-/raw/master/archmanmirror' 'archmanmirror';
add_mirrorlist 'rebornos-mirrorlist' 'https://raw.githubusercontent.com/RebornOS-Team/rebornos-mirrorlist/main/reborn-mirrorlist' 'reborn-mirrorlist';

add_mirrorlist 'cachyos-mirrorlist' 'https://raw.githubusercontent.com/CachyOS/CachyOS-PKGBUILDS/master/cachyos-mirrorlist/cachyos-mirrorlist';
for v in 3 4; do [ "`pacman -T cachyos-v$v-mirrorlist`" ] || add_in_pactools "sed 's|\$arch|\$arch_v$v|' /etc/pacman.d/cachyos-mirrorlist | sudo tee /etc/pacman.d/cachyos-v$v-mirrorlist >/dev/null"; done;

add_mirrorlist 'arcolinux-mirrorlist-git' 'https://raw.githubusercontent.com/arcolinux/arcolinux-mirrorlist/master/etc/pacman.d/arcolinux-mirrorlist' 'arcolinux-mirrorlist';
add_mirrorlist 'endeavouros-mirrorlist' 'https://gitlab.com/endeavouros-filemirror/PKGBUILDS/-/raw/master/endeavouros-mirrorlist/endeavouros-mirrorlist';
add_mirrorlist 'chaotic-mirrorlist' 'https://aur.chaotic.cx/mirrorlist.txt';
add_mirrorlist 'blackarch-mirrorlist' 'https://raw.githubusercontent.com/BlackArch/blackarch-site/master/blackarch-mirrorlist';
add_mirrorlist 'artix-mirrorlist' 'https://gitea.artixlinux.org/packages/artix-mirrorlist/raw/branch/master/mirrorlist';
add_mirrorlist 'pacman-mirrors' 'https://repo.manjaro.org/mirrors.json' 'mirrorlist' 'stable/$repo/$arch';
add_arch_mirrorlist 'pacman-mirrorlist'; add_arch_mirrorlist 'archlinux-mirrorlist' archlinux-;

add_in_pactools 'sudo pacman -Syy'