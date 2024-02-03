#!/bin/sh

cd `realpath $(dirname $0)` || exit 1
. ./pactools.sh >/dev/null

check_sudo

printf "Install pactools\n\n"

if ! pacman -T curl git pacman-contrib sed >/dev/null; then
    check_internet
    echo "Install packages required"
    sudo pacman -S --noconfirm `pacman -T curl git pacman-contrib sed`
fi

sudo chmod +x ./*.sh

echo "Add pactools command"
sudo cp ./pactools.sh /usr/local/bin/pactools

echo "Config update mirrors command"
./install_update_mirrors.sh

printf "\nWould you want to remove the installation script ? [Y/n] "; read -r
[ "`echo $REPLY | tr N n | cut -c1`" = n ] || sudo rm -rf ../pactools

printf "\nSuccess to install pactools\n"
exit 0
