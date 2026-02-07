if [ -n "$BASH_VERSION" ]; then
    #!/bin/bash
    echo " "
fi

# Hi! this is the script that installs some dependencies, like DE, python, and the most important, dotnet (well, is a C# based OS, what are you expecting?)
# this script also removes some conflicting packages, like ubuntu-desktop (from the base Ubuntu), it also substutes gnome-terminal with konsole (KDE terminal) and apt with nala

# Code by NyanRay64 =3

# Configure the newuser.sh
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
  echo "installing and setting up Plasma desktop and utilities..."
  sudo apt install kde-plasma -y
  sudo apt install gdm -y
  sudo systemctl enable gdm3
  echo "done."
  new-usersetting
  # Install some KDE apps
  echo "installing KDE applications and utilities..."
  sudo apt install kde-applications
  sudo apt install tilix
  sudo apt install nautilus
  sudo apt install gnome-sushi -y # i know, is contradictory, but gnome-sushi is a nice file previewer and Ubuntu already needs nautilus to work properly
  echo "done."
}

fedora() {
  sudo dnv update && sudo dnf upgrade
  echo "installing and setting up Plasma desktop..."
  sudo dnf install plasma-desktop -y
  sudo dnf install gdm -y
  sudo systemctl enable gdm3
  echo "done."
  new-usersetting
  echo "installing KDE applications and utilities..."
  sudo dnf install kde-applications
  sudo dnf install tilix
  sudo dnf install nautilus
  sudo dnf install gnome-sushi
  echo "done."
}

arch() {
  sudo pacman -Syu
  echo "installing and setting up Plasma desktop..."
  sudo pacman -S plasma-desktop -y
  sudo pacman -S gdm -y
  sudo systemctl enable gdm3
  echo "done."
  new-usersetting
  echo "installing KDE applications and utilities..."
  sudo pacman -S kde-applications
  yay -S tilix
  sudo pacman -S nautilus
  yay -S sushi
  echo "done."
}

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
