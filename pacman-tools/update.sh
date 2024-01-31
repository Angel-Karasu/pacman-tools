#!/bin/sh

if [[ $(ping -c 1 -q github.com >&/dev/null; echo $?) ]]; then
    if sudo -v; then
        cd $(realpath `dirname $0`)
        sudo git clone https://github.com/Angel-Karasu/pacman-tools.git update
        sudo chmod +x ./update/install.sh
        ./update/install.sh
        sudo rm -rf ./update

        echo -e "\nSuccess to update pacman-tools"
        exit 0
    else echo "Root privileges denied"; fi
else echo "Error: No Internet connection"; fi

exit 1