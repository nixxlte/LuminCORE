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

# Set up Phantom
phantom() {
  echo "Setting up phantom"
  cd ~/
  git clone https://github.com/nixxlte/Phantom
  cd Phantom
}

check-install() {
  echo "making sure everything is okay..."
  dotnet --list-sdks
  dotnet --list-runtimes
  git --version
  nala --version
  python3 --version
  echo "done."
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
  echo "installing LuminOS dependencies..."
  sudo apt install nala python3 python3-pip git wget neofetch -y
  sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-8.0
  sudo apt install snapd
  snap install dotnet-runtime --classic
  snap install dotnet --classic
  dotnet new install Avalonia.Templates # Phantom GUI needs this, also almost every UI C# app on Lumin/Linux
  sudo apt install qtchooser
  echo "done."
  # Install some Phantom dependencies
  echo "installing Phantom dependencies..."
  sudo apt install \
      libsdl2-2.0-0 \
      libsdl2-image-2.0-0 \
      libsdl2-ttf-2.0-0 \
      libsdl2-mixer-2.0-0 # Thanks to raice by helping me do the Phantom lib =3
  sudo apt install \
      libsdl2-2.0-0 \
      libsdl2-image-2.0-0 \
      libsdl2-ttf-2.0-0 \
      libsdl2-mixer-2.0-0
  echo "done."
  check-install
  # Set up nala (debian exclusive)
  echo "setting up nala..."
  echo 'alias apt=nala' >> ~/.bashrc
  source ~/.bashrc
  nala update && nala upgrade -y
  echo "done."
  phantom
  echo "done."
  neofetch
  echo "You're all set up! welcome to LuminOS!"
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
  echo "installing LuminOS dependencies..."
  sudo dnf install python3 python3-pip git wget neofetch -y
  sudo dnf update && sudo dnf install dotnet-sdk-8.0 -y
  sudo dnf install snapd
  snap install dotnet-runtime --classic
  snap install dotnet --classic
  dotnet new install Avalonia.Templates # Phantom GUI needs this, also almost every UI C# app on Lumin/Linux
  sudo dnf install qtchooser
  echo "done."
  # Install some Phantom dependencies
  echo "installing Phantom dependencies..."
  sudo dnf install \
      libsdl2-2.0-0 \
      libsdl2-image-2.0-0 \
      libsdl2-ttf-2.0-0 \
      libsdl2-mixer-2.0-0 # Thanks to raice by helping me do the Phantom lib =3
  sudo dnf install \
      libsdl2-2.0-0 \
      libsdl2-image-2.0-0 \
      libsdl2-ttf-2.0-0 \
      libsdl2-mixer-2.0-0
  echo "done."
  check-install
  phantom
  echo "done."
  neofetch
  echo "You're all set up! welcome to LuminOS!"
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
  echo "installing LuminOS dependencies..."
  sudo pacman -S python3 python3-pip git wget fastfetch -y
  sudo pacman -Syu && sudo pacman -S dotnet-sdk-8.0
  yay -S snapd
  snap install dotnet-runtime --classic
  snap install dotnet --classic
  dotnet new install Avalonia.Templates # Phantom GUI needs this, also almost every UI C# app on Lumin/Linux
  yay -S qfsm
  echo "done."
  sudo pacman -S sdl2_image sdl2_ttf sdl2 sdl2_mixer
  echo "done."
  check-install
  phantom
  echo "done."
  fastfetch
  echo "You're all set up! welcome to LuminOS!"
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
