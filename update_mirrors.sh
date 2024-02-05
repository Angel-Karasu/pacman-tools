#!/bin/sh

update_mirror_list() {
    for server in `curl -s "$1" | sed -e "/Server/b" -e d | tr -d '# '`; do
        t=`ping -c 1 "$(echo $server | sed 's|.*//||; s|/.*||')" 2>/dev/null | tail -1 | cut -d '/' -f 5`
        echo `echo $server | sed "s|.*=||"`"  **$t**"
        [ "$t" ] && list+=" $t,$server"
    done

    echo "$list" | tr ' ' '\n' | sort -t',' -k1,1n | sed 's|.*,||; s|=| = |g' | sudo tee /etc/pacman.d/$2

    printf "\nSuccess to update mirrors\n\n"
}
