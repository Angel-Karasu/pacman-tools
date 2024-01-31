#!/bin/sh

cd $(realpath `dirname $0`)
source ./check_status.sh

check_internet
check_sudo

sudo git clone https://github.com/Angel-Karasu/pacman-tools.git update
sudo chmod +x ./update/install.sh
./update/install.sh
sudo rm -rf ./update

echo -e "\nSuccess to update pacman-tools"
exit 0