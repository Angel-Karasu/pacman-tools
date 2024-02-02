# Pacman Tools

This is a simple set of tools for pacman, the package manager for Arch Linux-based distributions. It can clean pacman cache, remove unused packages, fix pacman keys and update pacman mirrors.

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

### Commands

To get the list of commands :

- For pacman cleaner :
```shell
clean-pacman -h
```

- For fix the keys
```shell
fix-keys -h
```

- To update the mirrors
```shell
update-mirrors -h
```

### Update

To update pacman-tools, run :
```shell
update-pacman-tools
```

### Uninstall

To uninstall pacman-tools, run :
```shell
/etc/pacman.d/pacman-tools/uninstall.sh
```

## Compatible

- Arch based-distributions compatible : 
  - Arch Linux
  - Artix Linux

- Shell aliases available :
  - bash

## To do

- Add more Arch based-distributions compatible
  - [ ] EndeavourOS
  - [ ] Garuda
  - [ ] Manjaro
  
- Add aliases for other shells
  - [ ] Fish
  - [ ] ZSH

## License

This project is licensed under the [GNU GPLv3](https://choosealicense.com/licenses/gpl-3.0/). See the `LICENSE` file for details.

## Contributing

Contributions are welcome. Please open an issue or a pull request if you want to help improve the project.
