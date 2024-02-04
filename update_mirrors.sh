#!/bin/sh

. /etc/os-release

update_mirror_list() {
    file=/etc/pacman.d/$2
    curl -s $1 | sed 's/#Server/Server/' | rankmirrors -w -n 6 - | sudo tee $file && sudo sed -i '/#/d' $file

    printf "\nSuccess to update mirrors\n\n"
}
