#!/bin/sh

cd `realpath $(dirname $0)` || exit 1
. ./check_status.sh

check_internet
check_sudo

sudo git clone https://github.com/Angel-Karasu/pacman-tools.git
sudo chmod +x ./pacman-tools/install.sh
sudo sed -i 's|\binstall\b|update|g; s|Add|Update|g; s|printf|#printf|g'  ./pacman-tools/install.sh
./pacman-tools/install.sh

exit 0