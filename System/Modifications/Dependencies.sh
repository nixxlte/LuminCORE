#!/bin/bash

sudo apt update && sudo apt upgrade -y

# Hi! this is the script that installs some dependencies, like DE, python, and the most important, dotnet (well, is a C# based OS, what are you expecting?)
# this script also removes some conflicting packages, like ubuntu-desktop (from the base Ubuntu), it also substutes gnome-terminal with konsole (KDE terminal) and apt with nala

sudo su # this script needs root permissions, cause it installs and sets up somethings

# Install and configure KDE-plasma
echo "installing and seting up Plasma desktop..."
apt install kde-plasma -y
systemctl enable gdm3
apt remove ubuntu-desktop
echo "done."

# Install some KDE apps, instead of GNOME apps
echo "installing KDE applications..."
apt install kde-applications -y
apt remove gnome-terminal -y
apt install gnome-sushi -y # i know, is contradictory, but gnome-sushi is a nice file previewer and Ubuntu already needs nautilus to work properly
apt install tilix # a good terminal emulator :D
echo "done."

# Install some dependencies
echo "installing LuminOS dependencies..."
apt install nala python3 python3-pip git wget neofetch -y
sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-8.0
snap install dotnet-runtime --classic
snap install dotnet --classic
dotnet new install Avalonia.Templates # Phantom GUI needs this, also almost every UI C# app on Lumin/Linux
apt install qtchooser
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

# Check the instalation
echo "making sure everything is okay..."
dotnet --list-sdks
dotnet --list-runtimes
git --version
nala --version
python3 --version
echo "done."

# Set up nala
echo "setting up nala..."
echo 'alias apt=nala' >> ~/.bashrc
source ~/.bashrc
nala update && nala upgrade -y
echo "done."

# Set up Phantom (build 2097 R2 or newer)
cd ~/
git clone https://github.com/nixxlte/Phantom
cd Phantom
apt install gcc

# Final message
neofetch
echo "You're all set up! welcome to LuminOS!"