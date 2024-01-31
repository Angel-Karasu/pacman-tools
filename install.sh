#!/bin/sh

BASE_DIR=$(realpath `dirname $0`)

if sudo -v; then
    echo -e "Install pacman-tools\n"

    echo "Add the scripts in /etc/pacman.d/pacman-tools/"
    sudo cp -r $BASE_DIR/pacman-tools /etc/pacman.d/
    sudo chmod -R +x /etc/pacman.d/pacman-tools/

    echo "Add aliases for bash"
    sudo cp $BASE_DIR/pacman_tools.bashrc /etc/bash/bashrc.d/

    if [[ ! $(pacman -Qi curl git pacman-contrib sed >&/dev/null; echo $?) ]]; then
        if [[ $(ping -c 1 -q github.com >&/dev/null; echo $?) ]]; then
            echo "Install packages required"
            sudo pacman -S --needed --noconfirm curl git pacman-contrib sed 2>/dev/null
        else echo "Before to use, you must have curl, git, pacman-contrib and sed installed"; fi
    fi

    echo -e "\nSuccess to install pacman-tools"
    exit 0
else
    echo "Root privileges denied"
    exit 1
fi