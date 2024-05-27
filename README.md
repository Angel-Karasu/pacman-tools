# PacTools

This is a simple toolkit project for pacman, the package manager for Arch Linux-based distributions. It can clean pacman cache, remove unused packages, fix pacman keys, reinstall all packages and update pacman mirrors.

## Installation

Clone this repository and run the install script
```shell
git clone https://github.com/Angel-Karasu/pactools.git;
cd pactools; chmod +x ./install.sh;
./install.sh;
```

## How to use

- To get help, run :
```shell
pactools -h #pactools --help
```

- To clean pacman, run :
```shell
pactools -c #pactools --clean
```

- To fix pacman keys, run :
```shell
pactools -f #pactools --fix-keys
```

- To reinstall all packages, run :
```shell
pactools -r #pactools --reinstall
```

- To update pacman mirrors, run :
```shell
pactools -u #pactools --update-mirrors
```

- To update pactools, run :
```shell
pactools --update
```

- To uninstall pactools, run :
```shell
pactools --uninstall
```

## Compatible mirror list

- [Arch Linux](https://archlinux.org/mirrorlist/?country=all&protocol=https&use_mirror_status=on)
  - Package, file : `pacman-mirrorlist`, `mirrorlist`
  - Package, file : `archlinux-mirrorlist`

- [ArcoLinux](https://raw.githubusercontent.com/arcolinux/arcolinux-mirrorlist/master/etc/pacman.d/arcolinux-mirrorlist)
  - Package, file : `arcolinux-mirrorlist-git`, `arcolinux-mirrorlist`

- [Artix Linux](https://gitea.artixlinux.org/packages/artix-mirrorlist/raw/branch/master/mirrorlist)
  - Package, file : `artix-mirrorlist` | `pacman-mirrorlist`, `mirrorlist`

- [BlackArch](https://raw.githubusercontent.com/BlackArch/blackarch-site/master/blackarch-mirrorlist)
  - Package, file : `blackarch-mirrorlist`

- [CachyOS](https://raw.githubusercontent.com/CachyOS/CachyOS-PKGBUILDS/master/cachyos-mirrorlist/cachyos-mirrorlist)
  - Package, file : `cachyos-mirrorlist`

- [CachyOS-v3](https://raw.githubusercontent.com/CachyOS/CachyOS-PKGBUILDS/master/cachyos-v3-mirrorlist/cachyos-v3-mirrorlist)
  - Package, file : `cachyos-v3-mirrorlist`

- [CachyOS-v4](https://raw.githubusercontent.com/CachyOS/CachyOS-PKGBUILDS/master/cachyos-v4-mirrorlist/cachyos-v4-mirrorlist)
  - Package, file : `cachyos-v4-mirrorlist`

- [EndeavourOS](https://gitlab.com/endeavouros-filemirror/PKGBUILDS/-/raw/master/endeavouros-mirrorlist/endeavouros-mirrorlist)
  - Package, file : `endeavouros-mirrorlist`

- [Hyperbola](https://www.hyperbola.info/mirrorlist/?country=all&protocol=https&use_mirror_status=on)
  - Package, file : `pacman-mirrorlist`, `mirrorlist`

- [KaOS](https://raw.githubusercontent.com/KaOSx/core/master/pacman-mirrorlist/mirrorlist)
  - Package, file : `pacman-mirrorlist`, `mirrorlist`

- [Manjaro](https://repo.manjaro.org/mirrors.json)
  - Package, file : `pacman-mirrors` | `pacman-mirrors-dev` | `pacman-mirrorlist`, `mirrorlist`

- [Parabola](https://www.parabola.nu/mirrorlist/?country=all&protocol=https&use_mirror_status=on)
  - Package, file : `pacman-mirrorlist`, `mirrorlist`

- [RebornOS](https://raw.githubusercontent.com/RebornOS-Team/rebornos-mirrorlist/main/reborn-mirrorlist)
  - Package, file : `rebornos-mirrorlist`, `reborn-mirrorlist`

*Files are located in : `/etc/pacman.d/`*

## List of Arch Linux-based tested distributions

- [Arch Linux](https://distrowatch.com/table.php?distribution=arch)
- [ArchBang](https://distrowatch.com/table.php?distribution=archbang)
- [ArchCraft](https://distrowatch.com/table.php?distribution=archcraft)
- [Archman](https://distrowatch.com/table.php?distribution=archman)
- [ArcoLinux](https://distrowatch.com/table.php?distribution=arco)
- [Artix Linux](https://distrowatch.com/table.php?distribution=artix)
- [Athena OS](https://distrowatch.com/table.php?distribution=athena)
- [BigLinux](https://distrowatch.com/table.php?distribution=biglinux)
- [BlackArch](https://distrowatch.com/table.php?distribution=blackarch)
- [BlendOS](https://distrowatch.com/table.php?distribution=blendos)
- [Bluestar Linux](https://distrowatch.com/table.php?distribution=bluestar)
- [CachyOS](https://distrowatch.com/table.php?distribution=Cachyos)
- [EndeavourOS](https://distrowatch.com/table.php?distribution=endeavour)
- [Garuda](https://distrowatch.com/table.php?distribution=garuda)
- [Hyperbola](https://distrowatch.com/table.php?distribution=hyperbola)
- [KaOS](https://distrowatch.com/table.php?distribution=kaos)
- [Liya](https://distrowatch.com/table.php?distribution=liya)
- [Mabox Linux](https://distrowatch.com/table.php?distribution=mabox)
- [Manjaro](https://distrowatch.com/table.php?distribution=manjaro)
- [Obarun](https://distrowatch.com/table.php?distribution=obarun)
- [Parabola](https://distrowatch.com/table.php?distribution=parabola)
- [RebornOS](https://distrowatch.com/table.php?distribution=rebornos)
- [SDesk](https://distrowatch.com/table.php?distribution=sdesk)
- [Snal Linux](https://distrowatch.com/table.php?distribution=snal)

## To do

- [ ] Publish on AUR (Arch User Repository)

## License

This project is licensed under the [GNU GPLv3](https://choosealicense.com/licenses/gpl-3.0/).

See the `LICENSE` file for details.

## Contributing

Contributions are welcome. Please open an issue or a pull request if you want to help improve the project.
