#!/bin/sh

help() {
  echo "Usage : pactools [COMMAND]"; echo
  echo "Commands :"
  echo "  -h, --help            : Display this help."
  echo "  -c, --clean           : Clean pacman cache and remove unused dependencies."
  echo "  -f, --fix-keys        : Refresh pacman keys."
  echo "  -r, --reinstall       : Reinstall packages."
  echo "  -u, --update-mirrors  : Update pacman mirrors."
  echo
  echo "      --update          : Update pactools."
  echo "      --uninstall       : Uninstall pactools."
  echo
  echo "Use 'pactools [COMMAND] -h' to get help about the command"; echo
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
  help() {
    echo "Usage : pactools --clean [OPTIONS]"; echo
    echo "Commands :"
    echo "  -h, --help      : Display this help."
    echo
    echo "Options :"
    echo "  -n, --noconfirm : Clean without confirmation."
    echo
  }

  case "$2" in
    -h|--help)
      help
      exit 0
    ;;
    -n|--noconfirm) noconfirm=--noconfirm;;
  esac

  check_sudo

  sudo pacman -Scc $noconfirm; echo

  remove_dpds() { [ "$@" ] && sudo pacman --noconfirm -Rsn $@; }

  dependencies="`pacman -Qdtq`"
  if [ "$noconfirm" ]; then remove_dpds $dependencies
  elif [ "$dependencies" ]; then
    echo "Unused dependencies :"
    for d in $dependencies; do
      i=$(( $i + 1))
      echo "  $i. $d"
    done
    printf "\nEnter numbers of package you want to remove (e.g., '1 2', '1-3') : "; read -r
    for nb_dpds in $REPLY; do
      if [ "`echo "$nb_dpds" | tr -cd '-'`" ]; then
        remove_dpds "`echo $dependencies | tr ' ' '\n' | sed -n \"$(echo $nb_dpds | sed 's|-.*||'),$(echo $nb_dpds | sed 's|.*-||')p\"`"
      else remove_dpds "`echo $dependencies | tr ' ' '\n' | sed -n \"$(echo $nb_dpds)p\"`"; fi
    done
  fi
}

fix_keys() {
  help() {
    echo "Usage : pactools --fix-keys [OPTIONS]"; echo
    echo "Commands :"
    echo "  -h, --help : Display this help."
    echo
    echo "Options :"
    echo "  -a, --all  : Reinstall all keyrings."
    echo
  }

  case "$2" in
    -h|--help)
      help
      exit 0
    ;;
    -a|--all) all=true;;
  esac

  check_internet
  check_sudo
  . /etc/os-release

  fix_keyring() {
    if [ "$1" ]; then
      sudo pacman-key --populate `echo $1 | sed "s/-keyring//g"`
      sudo pacman -S --noconfirm $1
      echo; echo "Success to fix $1"; echo
    fi
  }
  
  keyrings=`pacman -Qq | sed -e "/keyring/b" -e d`
  keyrings="`echo $keyrings | tr ' ' '\n' | sed -e \"/$ID/b\" -e d` `echo $keyrings | tr ' ' '\n' | sed \"/$ID/d\"`"
  if [ "$all" ]; then
    sudo rm -rf /etc/pacman.d/gnupg /var/lib/pacman/sync
    sudo pacman -Syy
    sudo pacman-key --init
    for keyring in $keyrings; do fix_keyring $keyring; done
  else
    echo "Keyrings :"
    for k in $keyrings; do
      i=$(( $i + 1))
      echo "  $i. $k"
    done
    printf "\nEnter numbers of keyring you want to reinstall (e.g., '1 2', '1-3') : "; read -r
    for nb_key in $REPLY; do
      if [ "`echo "$nb_key" | tr -cd '-'`" ]; then
        fix_keyring "`echo $keyrings | tr ' ' '\n' | sed -n \"$(echo $nb_key | sed 's|-.*||'),$(echo $nb_key | sed 's|.*-||')p\"`"
      else fix_keyring "`echo $keyrings | tr ' ' '\n' | sed -n \"$(echo $nb_key)p\"`"; fi
    done
  fi
}

reinstall_packages() {
  help() {
    echo "Usage : pactools --reinstall [OPTIONS]"; echo
    echo "Commands :"
    echo "  -h, --help          : Display this help."
    echo
    echo "Options :"
    echo "  -d, --dependencies  : Reinstall only dependencies installed packages."
    echo "  -e, --explicit      : Reinstall only explicit installed packages."
    echo
  }

  case "$1" in
    -h|--help)
      help
      exit 0
    ;;
    -d|--dependencies) opt=d;;
    -e|--explicit) opt=e;;
  esac

  sudo pacman -S --noconfirm `pacman -Qnq$opt`
}

update_mirrors() {
  help() {
    echo "Usage : pactools --update-mirrors [OPTIONS]"; echo
    echo "Commands :"
    echo "  -h, --help            : Display this help."
    echo
    echo "Options :"
    echo "  -m, --max-time  VALUE : Set number of seconds before timeout, default=2.0"
    echo "  -s, --server    VALUE : Set number of servers saved, default=5"
    echo
  }

  max_time=2
  nb_server=5

  while [ $# != 0 ]; do
    case "$1" in
      -h|--help)
        help
        exit 0
      ;;
      -m|--max-time)
        if [ "$2" ]; then
          max_time=$2
          shift 2
        else shift; fi
      ;;
      -s|--server)
        if [ "$2" -gt 1 ]; then
          nb_server=$(($2+1))
          shift 2
        else shift; fi
      ;;
      -u|--update-mirrors) shift;;
      *)
        echo "Error: Unknown option '$1'"
        help
        exit 1
      ;;
    esac
  done

  check_internet
  check_sudo
  arch=`uname -m`

  update_mirror_list() {
    repo="$2"
    list=""
    for server in `curl -s "$1" | tr -d '"#, ' | sed -e 's|url:|Server=|g; /Server/b' -e d | sed -e '/https/b' -e d`; do
      server="$server$4"
      eval $server
      res=`curl -s -m $max_time "$Server/$repo.db" -o /dev/null -w "%{time_total} %{http_code}"`
      printf $Server
      if [ `echo $res | cut -d ' ' -f 2` = 200 ]; then
        t=`echo $res | cut -d ' ' -f 1`
        echo "  **$t**"
        list="$list $t,$server"
      else echo "  ****"; fi
    done

    echo "$list" | tr ' ' '\n' | sort -t',' -k1,1n | sed 's|.*,||; s|=| = |g' | head -$nb_server | sudo tee /etc/pacman.d/$3

    echo; echo "Success to update mirrors"; echo
  }

  # Start commands
  # End commands
}

update() {
  check_sudo
  
  sudo git clone https://github.com/Angel-Karasu/pactools.git /var/tmp/pactools || exit 1
  sudo chmod +x /var/tmp/pactools/install.sh
  sudo sed -i 's|Add|Update|g; s|Install|Update|g; s|install|update|g; s|printf|#printf|g' /var/tmp/pactools/install.sh
  echo
  sudo /var/tmp/pactools/install.sh
}

if [ $# = 0 ]; then help;
else
  case "$1" in
    -h|--help) help;;
    -c|--clean) clean_pacman "$@";;
    -f|--fix-keys) fix_keys "$@";;
    -r|--reinstall) reinstall_packages $2;;
    -u|--update-mirrors) update_mirrors "$@";;
    --update) update $2;;
    --uninstall) uninstall $2;;
    *)
      echo "Error: Unknown option '$1'"
      help
      exit 1
    ;;
  esac
  exit 0;
fi
