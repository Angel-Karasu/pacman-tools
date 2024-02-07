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
pactools -h
```

- To clean pacman, run :
```shell
pactools -c
```

- To fix pacman keys, run :
```shell
pactools -f
```

- To update pacman mirrors, run :
```shell
pactools -u
```

- To update pactools, run :
```shell
pactools --update
```

- To uninstall pactools, run :
```shell
pactools --uninstall
```

## Tested

- [x] [Arch Linux](https://distrowatch.com/table.php?distribution=arch)
- [ ] [Arch Linux ARM](https://archlinuxarm.org/)
- [ ] [Arch Linux CN](https://github.com/archlinuxcn/repo?tab=readme-ov-file)
- [ ] [ArchBang](https://distrowatch.com/table.php?distribution=archbang)
- [x] [ArchCraft](https://distrowatch.com/table.php?distribution=archcraft)
- [ ] [Archman](https://distrowatch.com/table.php?distribution=archman)
- [x] [ArcoLinux](https://distrowatch.com/table.php?distribution=arco)
- [x] [Artix Linux](https://distrowatch.com/table.php?distribution=artix)
- [ ] [Athena OS](https://distrowatch.com/table.php?distribution=athena)
- [x] [BigLinux](https://distrowatch.com/table.php?distribution=biglinux)
- [ ] [BlackArch](https://distrowatch.com/table.php?distribution=blackarch)
- [ ] [BlendOS](https://distrowatch.com/table.php?distribution=blendos)
- [ ] [Bluestar Linux](https://distrowatch.com/table.php?distribution=bluestar)
- [ ] [CachyOS](https://distrowatch.com/table.php?distribution=Cachyos)
- [x] [EndeavourOS](https://distrowatch.com/table.php?distribution=endeavour)
- [x] [Garuda](https://distrowatch.com/table.php?distribution=garuda)
- [ ] [Hyperbola](https://distrowatch.com/table.php?distribution=hyperbola)
- [ ] [KaOS](https://distrowatch.com/table.php?distribution=kaos)
- [ ] [Liya](https://distrowatch.com/table.php?distribution=liya)
- [ ] [Mabox Linux](https://distrowatch.com/table.php?distribution=mabox)
- [x] [Manjaro](https://distrowatch.com/table.php?distribution=manjaro)
- [ ] [Obarun](https://distrowatch.com/table.php?distribution=obarun)
- [ ] [Parabola](https://distrowatch.com/table.php?distribution=parabola)
- [x] [RebornOS](https://distrowatch.com/table.php?distribution=rebornos)
- [ ] [SDesk](https://distrowatch.com/table.php?distribution=sdesk)
- [ ] [Snal Linux](https://distrowatch.com/table.php?distribution=snal)

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
