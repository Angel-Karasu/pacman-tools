#!/bin/sh

cd $(realpath $(dirname $0))
source ./check_status.sh

usage() {
    printf "Usage : fix-keys [OPTIONS]\n\n"
    echo "Commands :"
    echo "  -h, --help  : Display this help."
    echo ""
    echo "Options :"
    echo "  -a, --all   : Clean all is can be clean."
    echo "  -c, --cache : Clean pacman cache."
    echo "  -d, --deps  : Remove unused dependencies."
    echo ""
}

cache() {
    check_sudo
    sudo pacman -Scc
}

dependencies() {
    check_sudo
    sudo pacman -Rsn $(pacman -Qdtq)
}

if [ "$#" = 0 ]; then
    usage
    exit 0
fi
while [ "$#" -ne 0 ]; do
    case "$1" in
        -h|--help)
            usage
            exit 0
            ;;
        -a|--all)
            cache
            dependencies
            exit 0
            ;;
        -c|--cache)
            cache
            shift
            ;;
        -d|--deps)
            dependencies
            shift
            ;;
        *)
            echo "Error: Unknown option '$1'"
            usage
            exit 1
            ;;
    esac
done

exit 0