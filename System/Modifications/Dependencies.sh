if [ -n "$BASH_VERSION" ]; then
    #!/bin/bash
    echo " "
fi

sudo su

if [ -f /etc/os-release ]; then
  . /etc/os-release

  if [ "$ID" = "arch" ]; then
    echo "Running in Arch-based distro"
  elif [ "$ID" = "ubuntu" ]; then
    echo "Running in Ubuntu-based distro"
  elif [ "$ID" = "debian" ]; then
    echo "Running in Debian-based distro"
  elif [ "$ID" = "manhjaro" ]; then
    echo "Running in Manjaro"
  else
    echo "Cant run on unrecognized system: $PRETTY_NAME, if it is based on a supported distro you can run onlineinstaller with -f"
  fi
else
  echo "Cant run on unrecognized system: if it is based on a supported distro you can run onlineinstaller with -f"
fi

if [ "$1" = "-f" ]; then
  echo "force installing dependencies (DEBIAN ONLY)"
fi