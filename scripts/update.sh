#!/bin/sh

cd `realpath $(dirname $0)` || exit 1
. check_status.sh

check_internet
check_sudo

sudo git clone https://github.com/Angel-Karasu/pacman-tools.git update
sudo chmod +x ./update/install.sh
sudo sed -i 's|\bInstall\b|Update|g; s|\binstall\b|update|g; s|Add|Update|g; s|read|#read|g'  ./update/install.sh
./update/install.sh
sudo rm -rf ./update

exit 0