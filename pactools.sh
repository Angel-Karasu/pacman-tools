#!/bin/sh

usage() {
    printf "Usage : pactools [OPTIONS] [TOOL]\n\n"
    echo "Commands :"
    echo "  -h, --help           : Display this help."
    echo "      --update         : Update pactools."
    echo "      --uninstall      : Uninstall pactools."
    echo ""
    echo "Options :"
    echo "  -q, --quiet          : Quiet mode."
    echo ""
    echo "Tools :"
    echo "  -c, --clean          : Clean pacman cache and remove unused dependencies."
    echo "  -f, --fix-keys       : Refresh pacman keys."
    echo "  -u, --update-mirrors : Update pacman mirrors."
    echo ""
}

check_internet() {
    if ! ping -c 1 -q github.com >/dev/null 2>&1; then
        echo "Error connecting to github"
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
    pacman -Qdt >/dev/null && sudo pacman -Rsn `pacman -Qdtq`
}

fix_keys() {
    check_internet
    check_sudo

    . /etc/os-release

    sudo rm -rf /etc/pacman.d/gnupg /var/lib/pacman/sync
    sudo pacman -Syy
    sudo pacman-key --init
    keyrings=`pacman -Qq | sed -e "/keyring/b" -e d`
    for keyring in `echo $keyrings | tr ' ' '\n' | sed -e "/$ID/b" -e d` `echo $keyrings | tr ' ' '\n' | sed "/$ID/d"`; do
        sudo pacman-key --populate `echo $keyring | sed "s/-keyring//g"`
        sudo pacman -S --noconfirm $keyring
        printf "\nSuccess to fix $keyring\n\n"
    done
}

update_mirrors() {
    check_internet
    check_sudo

    update_mirror_list() {
        for server in `curl -s "$1" | tr -d '"#, ' | sed -e 's|url:|Server=|g' -e "/Server/b" -e d`; do
            t=`ping -c 1 "$(echo $server | sed 's|.*//||; s|/.*||')" 2>/dev/null | tail -1 | cut -d '/' -f 5`
            echo `echo $server | sed "s|.*=||"`"  **$t**"
            [ "$t" ] && list+=" $t,$server"
        done

        echo "$list" | tr ' ' '\n' | sort -t',' -k1,1n | sed 's|.*,||; s|=| = |g' | head -6 | sudo tee /etc/pacman.d/$2

        printf "\nSuccess to update mirrors\n\n"
    }

    # Start commands
    # End commands
}

update() {
    check_internet
    check_sudo

    printf "Update pactools\n\n"
    
    sudo git clone https://github.com/Angel-Karasu/pactools.git /var/tmp/pactools || exit 1
    sudo chmod +x /var/tmp/pactools/install.sh
    sudo sed -i 's|Add|Update|g; s|printf|#printf|g'  /var/tmp/pactools/install.sh
    echo ""
    /var/tmp/pactools/install.sh

    printf "\nSuccess to update pactools\n"
}

uninstall() {
    sudo rm -f /usr/local/bin/pactools
    echo "Success to uninstall pactools"
}

run() { [ "$QUIET" ] && $1 >/dev/null || $1; }

if [ "$#" = 0 ]; then
    usage
else
    while [ "$#" -ne 0 ]; do 
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
            -q|--quiet)
                QUIET=true
                shift
                ;;
            -c|--clean)
                run clean_pacman
                exit 0
                ;;
            -f|--fix-keys)
                run fix_keys
                exit 0
                ;;
            -u|--update-mirrors)
                run update_mirrors
                exit 0
                ;;
            *)
                echo "Error: Unknown option '$1'"
                usage
                exit 1
                ;;
        esac
    done
fi
