# Pacman Tools

This is a simple set of tools for pacman, the package manager Arch Linux-based distributions. It can clean pacman cache, remove unused packages, fix pacman keys and update pacman mirrors.

## Installation

To install pacman tools, clone this repository and run the install script:

```shell
git clone https://github.com/Angel-Karasu/pacman-tools.git;
cd pacman-tools;
chmod +x ./install.sh;
./install.sh;
cd ../
```

## Usage

To get the list of commands :

- To get help, run :
```shell
pacman-tools -h
```

- To clean pacman, run :
```shell
pacman-tools -c
```

- To fix pacman keys, run :
```shell
pacman-tools -f
```

- To update pacman mirrors, run :
```shell
pacman-tools -u
```

To update pacman-tools, run :
```shell
pacman-tools --update
```

To uninstall pacman-tools, run :
```shell
pacman-tools --uninstall
```

## Compatible

- Arch based-distributions compatible : 
  - Arch Linux
  - Artix Linux

## To do

- Add more Arch based-distributions compatible
  - [ ] EndeavourOS
  - [ ] Garuda
  - [ ] Manjaro

## License

This project is licensed under the [GNU GPLv3](https://choosealicense.com/licenses/gpl-3.0/).
See the `LICENSE` file for details.

## Contributing

Contributions are welcome. Please open an issue or a pull request if you want to help improve the project.
