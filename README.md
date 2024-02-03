# Pacman Tools

This is a simple set of tools for pacman, the package manager Arch Linux-based distributions. It can clean pacman cache, remove unused packages, fix pacman keys and update pacman mirrors.

## Installation

To install pacman tools, clone this repository and run the install script:

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
