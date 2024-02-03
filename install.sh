#!/bin/sh

cd `realpath $(dirname $0)` || exit 1
. ./pacman_tools.sh >/dev/null

check_sudo

printf "Install pacman-tools\n\n"

if ! pacman -T curl git pacman-contrib sed >/dev/null; then
    check_internet
    echo "Install packages required"
    sudo pacman -S --noconfirm `pacman -T curl git pacman-contrib sed`
fi

sudo chmod +x ./*.sh

echo "Add pacman-tools command"
sudo cp ./pacman_tools.sh /usr/local/bin/pacman-tools

echo "Config update mirrors command"
./install_update_mirrors.sh

printf "\nWould you want to remove the installation script ? [Y/n] "; read -r
[ "`echo $REPLY | tr N n | cut -c1`" = n ] || sudo rm -rf ../pacman-tools

printf "\nSuccess to install pacman-tools\n"
exit 0
