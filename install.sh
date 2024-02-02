#!/bin/sh

cd `realpath $(dirname $0)` || exit 1
. scripts/check_status.sh

check_sudo

printf "Install pacman-tools\n\n"

if ! pacman -T curl git pacman-contrib sed >/dev/null; then
    check_internet
    echo "Install packages required"
    sudo pacman -S --needed --noconfirm `pacman -T curl git pacman-contrib sed`
fi

echo "Add the scripts in /etc/pacman.d/pacman-tools/"
sudo cp -r scripts/* /etc/pacman.d/pacman-tools/
sudo chmod -R +x /etc/pacman.d/pacman-tools/

echo "Add aliases for bash"
sudo cp pacman_tools.bashrc /etc/bash/bashrc.d/

printf "Would you want to remove the installation script ? [Y/n] "; read -r
[ "`echo $REPLY | tr N n | cut -c1`" = n ] || sudo rm -rf ../pacman-tools

printf "\nSuccess to install pacman-tools\n"
exit 0
