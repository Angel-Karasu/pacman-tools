#!/bin/sh

cd `realpath $(dirname $0)` || exit 1
. scripts/check_status.sh

check_sudo

printf "Install pacman-tools\n\n"

if ! pacman -Qi curl git pacman-contrib sed >/dev/null 2>&1; then
    check_internet
    echo "Install packages required"
    sudo pacman -S --needed --noconfirm curl git pacman-contrib sed 2>/dev/null
fi

echo "Add the scripts in /etc/pacman.d/pacman-tools/"
sudo cp -r scripts/* /etc/pacman.d/pacman-tools/
sudo chmod -R +x /etc/pacman.d/pacman-tools/

echo "Add aliases for bash"
sudo cp pacman_tools.bashrc /etc/bash/bashrc.d/

printf "Would you want to remove the installation script ? [Y/n] "; read -r
[ "`echo $REPLY | tr N n | cut -c1`" = n ] || rm -rf ../pacman-tools

printf "\nSuccess to install pacman-tools\n"
exit 0