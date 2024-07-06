#!/bin/sh

cd `realpath $(dirname $0)` || exit 1
. ./pactools.sh >/dev/null

check_sudo

echo "Install pactools"; echo

echo "Install packages required"
sudo pacman -S --needed --noconfirm curl git sed || exit 1

sudo chmod +x ./*.sh

echo "Config update mirrors"
./add_update_mirrors_commands.sh

echo "Add pactools command"
sudo cp ./pactools.sh /usr/local/bin/pactools

printf "\nWould you want to remove the installation folder ? [Y/n] "; read -r
[ "`echo $REPLY | tr N n | cut -c1`" = n ] || sudo rm -rf ../`realpath $(dirname $0)`

echo; echo "Success to install pactools"
exit 0