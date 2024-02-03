#!/bin/sh

usage() {
    printf "Usage : pacman-tools [TOOL]\n\n"
    echo "Commands :"
    echo "  -h, --help           : Display this help."
    echo "      --update         : Update pacman-tools."
    echo "      --uninstall      : Uninstall pacman-tools."
    echo ""
    echo "Tools :"
    echo "  -c, --clean          : Clean pacman cache and remove unused dependencies."
    echo "  -f, --fix-keys       : Refresh pacman keys."
    echo "  -u, --update-mirrors : Update pacman mirrors."
    echo ""
}

check_internet() {
    if ! ping -c 1 -q github.com >/dev/null 2>&1; then
        echo "Error: No Internet connection"
        exit 1
    fi
}
check_sudo() {
    if ! sudo -v; then
        echo "Root privileges denied";
        exit 1
    fi
}

clean_pacman() {
    check_sudo

    sudo pacman -Scc
    pacman -Qdtq >/dev/null && sudo pacman -Rsn `pacman -Qdtq`
}

fix_keys() {
    check_internet
    check_sudo

    sudo rm -rf /etc/pacman.d/gnupg /var/lib/pacman/sync
    sudo pacman -Syy
    sudo pacman-key --init
    for keyring in `pacman -Qq | sed -e "/keyring/b" -e d`; do
        sudo pacman-key --populate `echo $keyring | sed "s/-keyring//g"`
        sudo pacman -S --noconfirm $keyring
        printf "\nSuccess to fix $keyring\n"
    done
    exit 0
}

update_mirrors() {
    check_internet
    check_sudo

    /etc/pacman.d/update_mirrors.sh
    exit 0
}

update() {
    check_internet
    check_sudo

    sudo git clone https://github.com/Angel-Karasu/pacman-tools.git /var/tmp/pacman-tools
    sudo chmod +x /var/tmp/pacman-tools/install.sh
    sudo sed -i 's|\binstall\b|update|g; s|Add|Update|g; s|printf|#printf|g'  /var/tmp/pacman-tools/install.sh
    /var/tmp/pacman-tools/install.sh

    printf "\nSuccess to update pacman-tools\n"
    exit 0
}

uninstall() {
    sudo rm -rf /etc/pacman.d/update_mirrors.sh /usr/local/bin/pacman-tools
    echo "Success to uninstall pacman-tools"
    exit 0
}

if [ "$#" = 0 ]; then
    usage
else
    case "$1" in
        -h|--help)
            usage
            exit 0
            ;;
        --update)
            update
            exit 0
            ;;
        --uninstall)
            uninstall
            exit 0
            ;;
        -c|--clean)
            clean_pacman
            exit 0
            ;;
        -f|--fix-keys)
            fix_keys
            exit 0
            ;;
        -u|--update-mirrors)
            update_mirrors
            exit 0
            ;;
        *)
            echo "Error: Unknown option '$1'"
            usage
            exit 1
            ;;
    esac
fi