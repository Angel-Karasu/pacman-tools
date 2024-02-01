#!/bin/sh

cd $(realpath $(dirname $0))
source ./check_status.sh

check_internet
check_sudo

sudo git clone https://github.com/Angel-Karasu/pacman-tools.git update
sudo chmod +x ./update/install.sh
sudo sed -i -e 's/\bInstall\b/Update/g' -e 's/Add/Update/g' -e 's/read/#read/g'  install.sh
./update/install.sh
sudo rm -rf ./update

exit 0