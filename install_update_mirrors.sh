#!/bin/sh

. /etc/os-release
. ./pactools.sh >/dev/null

sudo cp update_mirrors.sh /etc/pacman.d/

UPDATE_MIRRORS_FILE=/etc/pacman.d/update_mirrors.sh
sudo chmod +x $UPDATE_MIRRORS_FILE

add_in_update_mirrrors() {
    echo "update_mirror_list '$1' '$2'" | sudo tee -a $UPDATE_MIRRORS_FILE >/dev/null
}

add_arch() {
    add_in_update_mirrrors "https://archlinux.org/mirrorlist/?country=all&protocol=https&use_mirror_status=on" mirrorlist$1
}

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
        check_package eos-rankmirrors
        echo 'eos-rankmirrors' | sudo tee -a $UPDATE_MIRRORS_FILE >/dev/null
        add_arch
        ;;
    garuda)
        check_package rate-mirrors
        echo 'rate-mirrors --protocol https --save /etc/pacman.d/chaotic-mirrorlist --allow-root chaotic-aur' | sudo tee -a $UPDATE_MIRRORS_FILE >/dev/null
        add_arch
        ;;
    manjaro)
        check_package pacman-mirrors
        echo 'sudo pacman-mirrors --fasttrack 6' | sudo tee -a $UPDATE_MIRRORS_FILE >/dev/null;;
    *)
        echo "$ID is not compatible."
        exit 1
        ;;
esac

echo 'sudo pacman -Syy' | sudo tee -a $UPDATE_MIRRORS_FILE >/dev/null

exit 0
