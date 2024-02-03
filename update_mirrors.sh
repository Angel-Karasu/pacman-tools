#!/bin/sh

. /etc/os-release

update_mirror_list() {
    file=/etc/pacman.d/mirrorlist`[ $ID = $1 ] || echo -$1`
    curl -s $2 | sed 's/#Server/Server/' | rankmirrors -w -n 6 - | sudo tee $file && sudo sed -i '/^#/d' $file

    printf "\nSuccess to update $1 mirrors\n"
}
