#!/bin/sh

usage() {
    printf "Usage : pactools [COMMAND]\n\n"
    echo "Commands :"
    echo "  -h, --help           : Display this help."
    echo "  -c, --clean          : Clean pacman cache and remove unused dependencies."
    echo "  -f, --fix-keys       : Refresh pacman keys."
    echo "  -u, --update-mirrors : Update pacman mirrors."
    echo "      --update         : Update pactools."
    echo "      --uninstall      : Uninstall pactools."
    echo ""
    echo "Use 'pactools [COMMAND] -h' to get help about this command"
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
    usage() {
        printf "Usage : pactools --clean [OPTIONS]\n\n"
        echo "Commands :"
        echo "  -h, --help      : Display this help."
        echo ""
        echo "Options :"
        echo "  -n, --noconfirm : Clean without confirmation."
        echo ""
    }
    case "$2" in
        -h|--help)
            usage
            exit 0;;
        -n|--noconfirm) noconfirm=--noconfirm;;
    esac

    check_sudo

    sudo pacman -Scc $noconfirm; echo ""

    remove_dpds() { [ "$@" ] && sudo pacman --noconfirm -Rsn "$@"; }
    dependencies="`pacman -Qdtq`"
    if [ "$noconfirm" ]; then remove_dpds $dependencies
    elif [ "$dependencies" ]; then
        echo "Unused dependencies :"
        for d in $dependencies; do
            i=$(( $i + 1))
            echo "  $i. $d"
        done
        printf "\nEnter numbers of packages you want to remove (e.g., '1 2', '1-3') : "; read -r
        for nb_dpds in $REPLY; do
            if [ "`echo "$nb_dpds" | tr -cd '-'`" ]; then
                remove_dpds "`echo $dependencies | tr ' ' '\n' | sed -n \"$(echo $nb_dpds | sed 's|-.*||'),$(echo $nb_dpds | sed 's|.*-||')p\"`"
            else remove_dpds "`echo $dependencies | tr ' ' '\n' | sed -n \"$(echo $nb_dpds)p\"`"
            fi
        done
    fi
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
    usage() {
        printf "Usage : pactools --update-mirrors [OPTIONS]\n\n"
        echo "Commands :"
        echo "  -h, --help         : Display this help."
        echo ""
        echo "Options :"
        echo "  -p, --ping   VALUE : Set number of ping to increase precision, default=3."
        echo "  -s, --server VALUE : Set number of server saved, default=5."
        echo ""
    }

    nb_ping=3
    nb_server=5

    while [ $# != 0 ]; do
        case "$1" in
            -h|--help)
                usage
                exit 0;;
            -p|--precision)
                if [ "$2" -gt 0 ]; then
                    nb_ping=$2
                    shift 2
                else shift; fi;;
            -s|--server)
                if [ "$2" -gt 1 ]; then
                    nb_server=$(($2+1))
                    shift 2
                else shift; fi;;
            -u|--update-mirrors) shift;;
            *)
                echo "Error: Unknown option '$1'"
                usage
                exit 1;;
        esac
    done

    check_internet
    check_sudo

    update_mirror_list() {
        list=""
        for server in `curl -s "$1" | tr -d '"#, ' | sed -e 's|url:|Server=|g; /Server/b' -e d | sed -e '/https/b' -e d`; do
            server=$server$3
            t=`ping -c $nb_ping "$(echo $server | sed 's|.*//||; s|/.*||')" 2>/dev/null | tail -1 | cut -d '/' -f 5`
            echo `echo $server | sed "s|.*=||"`"  **$t**"
            [ "$t" ] && list="$list $t,$server"
        done

        echo "$list" | tr ' ' '\n' | sort -t',' -k1,1n | sed 's|.*,||; s|=| = |g' | head -$nb_server | sudo tee /etc/pacman.d/$2

        printf "\nSuccess to update mirrors\n\n"
    }

    # Start commands
 	update_mirror_list 'https://gitea.artixlinux.org/packages/artix-mirrorlist/raw/branch/master/mirrorlist' 'mirrorlist' ''
 	update_mirror_list 'https://archlinux.org/mirrorlist/?country=all&protocol=https&use_mirror_status=on' 'archlinux-mirrorlist' ''
 	sudo pacman -Syy
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

run() { if [ "$QUIET" ]; then $1 >/dev/null 2>&1; else $1; fi; }

if [ $# = 0 ]; then usage;
else
    case "$1" in
        -h|--help) usage;;
        -c|--clean) clean_pacman "$@";;
        -f|--fix-keys) fix_keys;;
        -u|--update-mirrors) update_mirrors "$@";;
        --update) update;;
        --uninstall) uninstall;;
        *)
            echo "Error: Unknown option '$1'"
            usage
            exit 1;;
    esac
    exit 0;
fi
