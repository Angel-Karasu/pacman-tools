#!/bin/sh

. /etc/os-release

sudo cp update_mirrors.sh /etc/pacman.d/

UPDATE_MIRRORS_FILE=/etc/pacman.d/update_mirrors.sh
sudo chmod +x $UPDATE_MIRRORS_FILE

add_in_update_mirrrors() {
    echo "update_mirror_list '$1' '$2'" | sudo tee -a $UPDATE_MIRRORS_FILE >/dev/null
}

add_arch() {
    add_in_update_mirrrors "https://archlinux.org/mirrorlist/?country=all&protocol=https&use_mirror_status=on" mirrorlist$1
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
    manjaro)
        echo 'sudo pacman-mirrors --fasttrack 6' | sudo tee -a $UPDATE_MIRRORS_FILE >/dev/null;;
    *)
        echo "$ID is not compatible."
        exit 1
        ;;
esac

echo 'sudo pacman -Syy' | sudo tee -a $UPDATE_MIRRORS_FILE >/dev/null

exit 0
