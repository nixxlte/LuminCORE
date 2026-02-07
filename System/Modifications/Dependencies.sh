if [ -n "$BASH_VERSION" ]; then
    #!/bin/bash
    echo " "
fi

new-usersetting() {
  mkdir /home/luminos
  cd /home/luminos
  git clone https://github.com/nixxlte/LuminCORE
  cd LuminCORE/System/Modifications
  cp NewUser.sh /home/
  echo "when you create a new user pls run 'sudo /home/NewUser.sh'"
}

debian() {
  sudo apt update && sudo apt upgrade
  echo "installing and setting up Plasma desktop..."
  sudo apt install kde-plasma -y
  sudo apt install gdm -y
  sudo systemctl enable gdm3
  echo "done."
  new-usersetting
  # Install some KDE apps
  echo "installing KDE applications..."
  sudo apt install kde-applications
  sudo apt install tilix
}

fedora() {
  sudo dnv update && sudo dnf upgrade
  echo "installing and setting up Plasma desktop..."
  sudo dnf install plasma-desktop -y
  sudo dnf install gdm -y
  sudo systemctl enable gdm3
  echo "done."
  new-usersetting
  echo "installing KDE applications..."
  sudo dnf install kde-applications
  sudo dnf install tilix
}

arch() {
  sudo pacman -Syu
  echo "installing and setting up Plasma desktop..."
  sudo pacman -S plasma-desktop -y
  sudo pacman -S gdm -y
  sudo systemctl enable gdm3
  echo "done."
  new-usersetting
  echo "installing KDE applications..."
  sudo pacman -S kde-applications
  yay -S tilix
}

# Code by NyanRay64 =3
if [ "$1" = "-f" ]; then
  # echo "force installing dependencies (DEBIAN ONLY)"
  if [ "$2" = "-deb" ]; then
    echo "force installing dependencies (DEBIAN MODE)"
    debian
  elif [ "$2" = "-dnf" ]; then
    echo "force installing dependencies (FEDORA MODE)"
    fedora
  elif [ "$2" = "-pacman" ]; then
    echo "force installing dependencies (ARCH MODE)"
    arch
  else
    echo "force installing dependencies (DEBIAN DEFAULT)"
    debian
  fi
elif [ "$1" = "" ]; then
  if [ -f /etc/os-release ]; then
    . /etc/os-release

    if [ "$ID" = "arch" ]; then
      echo "Running in Arch-based distro"
      arch
    elif [ "$ID" = "ubuntu" ]; then
      echo "Running in Ubuntu-based distro"
      debian
    elif [ "$ID" = "debian" ]; then
      echo "Running in Debian-based distro"
      debian
    elif [ "$ID" = "manhjaro" ]; then
      echo "Running in Manjaro"
      arch
    else
      echo "Cant run on unrecognized system: $PRETTY_NAME, if it is based on a supported distro you can run onlineinstaller with -f"
    fi
  else
    echo "Cant run on unrecognized system: if it is based on a supported distro you can run onlineinstaller with -f"
  fi
fi
