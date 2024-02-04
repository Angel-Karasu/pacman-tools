#!/bin/sh

. /etc/os-release
. ./pactools.sh >/dev/null

sed -i '/}/q' ./update_mirrors.sh

add_in_update_mirrrors() { echo "update_mirror_list '$1' '$2'" | sudo tee -a update_mirrors.sh >/dev/null; }

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
        check_package eos-rankmirrors
        echo 'eos-rankmirrors' | sudo tee -a update_mirrors.sh >/dev/null
        add_arch
        ;;
    garuda)
        check_package rate-mirrors
        CHAOTIC_FILE=/etc/pacman.d/chaotic-mirrorlist
        echo "rate-mirrors --protocol https --save $CHAOTIC_FILE --allow-root chaotic-aur && sudo sed -i '/#/d' $CHAOTIC_FILE" | sudo tee -a update_mirrors.sh >/dev/null
        add_arch
        ;;
    manjaro)
        check_package pacman-mirrors
        echo 'sudo pacman-mirrors --fasttrack 6' | sudo tee -a update_mirrors.sh >/dev/null;;
    *)
        echo "$ID is not compatible."
        exit 1
        ;;
esac

echo 'sudo pacman -Syy' | sudo tee -a update_mirrors.sh >/dev/null
sudo cp update_mirrors.sh /etc/pacman.d/
sudo chmod +x /etc/pacman.d/update_mirrors.sh

exit 0