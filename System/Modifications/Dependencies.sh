if [ -n "$BASH_VERSION" ]; then
    #!/bin/bash
    echo " "
fi

debian() {
  sudo apt update && sudo apt upgrade
}

fedora() {
  sudo dnv update && sudo dnf upgrade
}

arch() {
  sudo pacman -Syu
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