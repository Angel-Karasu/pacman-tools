# PacTools

This is a simple toolkit project for pacman, the package manager for Arch Linux-based distributions. It can clean pacman cache, remove unused packages, fix pacman keys and update pacman mirrors.

## Installation

To install pactools, clone this repository and run the install script
```shell
git clone https://github.com/Angel-Karasu/pactools.git;
cd pactools;
chmod +x ./install.sh;
./install.sh;
cd ../
```

## Usage

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
  - Package, file : `artix-mirrorlist`

- [BlackArch](https://raw.githubusercontent.com/BlackArch/blackarch-site/master/blackarch-mirrorlist)
  - Package, file : `blackarch-mirrorlist`

- [CachyOS](https://raw.githubusercontent.com/CachyOS/CachyOS-PKGBUILDS/master/cachyos-mirrorlist/cachyos-mirrorlist)
  - Package, file : `cachyos-mirrorlist`

- [Chaotic-AUR](https://aur.chaotic.cx/mirrorlist.txt)
  - Package, file : `chaotic-mirrorlist`

- [EndeavourOS](https://gitlab.com/endeavouros-filemirror/PKGBUILDS/-/raw/master/endeavouros-mirrorlist/endeavouros-mirrorlist)
  - Package, file : `endeavouros-mirrorlist`

- [KaOS](https://raw.githubusercontent.com/KaOSx/core/master/pacman-mirrorlist/mirrorlist)
  - Package, file : `pacman-mirrorlist`, `mirrorlist`

- [Manjaro](https://repo.manjaro.org/mirrors.json)
  - Package, file : `pacman-mirrors, pacman-mirrors-dev`, `mirrorlist`

- [RebornOS](https://raw.githubusercontent.com/RebornOS-Team/rebornos-mirrorlist/main/reborn-mirrorlist)
  - Package, file : `rebornos-mirrorlist`, `reborn-mirrorlist`

*Files are located in : `/etc/pacman.d/`*

## List of Arch Linux-based distributions

- [x] [Arch Linux](https://distrowatch.com/table.php?distribution=arch)
- [x] [ArchBang](https://distrowatch.com/table.php?distribution=archbang)
- [x] [ArchCraft](https://distrowatch.com/table.php?distribution=archcraft)
- [x] [Archman](https://distrowatch.com/table.php?distribution=archman)
- [x] [ArcoLinux](https://distrowatch.com/table.php?distribution=arco)
- [x] [Artix Linux](https://distrowatch.com/table.php?distribution=artix)
- [x] [Athena OS](https://distrowatch.com/table.php?distribution=athena)
- [x] [BigLinux](https://distrowatch.com/table.php?distribution=biglinux)
- [x] [BlackArch](https://distrowatch.com/table.php?distribution=blackarch)
- [x] [BlendOS](https://distrowatch.com/table.php?distribution=blendos)
- [X] [Bluestar Linux](https://distrowatch.com/table.php?distribution=bluestar)
- [x] [CachyOS](https://distrowatch.com/table.php?distribution=Cachyos)
- [x] [EndeavourOS](https://distrowatch.com/table.php?distribution=endeavour)
- [x] [Garuda](https://distrowatch.com/table.php?distribution=garuda)
- [ ] [Hyperbola](https://distrowatch.com/table.php?distribution=hyperbola)
- [x] [KaOS](https://distrowatch.com/table.php?distribution=kaos)
- [x] [Liya](https://distrowatch.com/table.php?distribution=liya)
- [x] [Mabox Linux](https://distrowatch.com/table.php?distribution=mabox)
- [x] [Manjaro](https://distrowatch.com/table.php?distribution=manjaro)
- [x] [Obarun](https://distrowatch.com/table.php?distribution=obarun)
- [ ] [Parabola](https://distrowatch.com/table.php?distribution=parabola)
- [x] [RebornOS](https://distrowatch.com/table.php?distribution=rebornos)
- [ ] [SDesk](https://distrowatch.com/table.php?distribution=sdesk)
- [ ] [Snal Linux](https://distrowatch.com/table.php?distribution=snal)

*sources : [DistroWatch](https://distrowatch.com)*

*It may work on untested distributions, but there's no guarantee.
- [x] *Tested distributions*
- [ ] *Not tested distributions*

## To do

- [ ] Testing distributions
- [ ] Add releases
- [ ] Publish on AUR (Arch User Repository)

## License

This project is licensed under the [GNU GPLv3](https://choosealicense.com/licenses/gpl-3.0/).

See the `LICENSE` file for details.

## Contributing

Contributions are welcome. Please open an issue or a pull request if you want to help improve the project.
