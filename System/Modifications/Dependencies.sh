#!/bin/bash

sudo apt update && sudo apt upgrade -y

# Hi! this is the script that installs some dependencies, like DE, python, and the most important, dotnet (well, is a C# based OS, what are you expecting?)
# this script also removes some conflicting packages, like ubuntu-desktop (from the base Ubuntu), it also substutes gnome-terminal with konsole (KDE terminal) and apt with nala

su # this script needs root permissions, cause it installs and sets up somethings

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
apt install konsole gnome-sushi -y # i know, is contradictory, but gnome-sushi is a nice file previewer
echo "done."

# Install some dependencies
echo "installing LuminOS dependencies..."
apt install nala python3 python3-pip git wget neofetch -y
snap install dotnet-sdk --classic
snap install dotnet-runtime --classic
snap install dotnet --classic
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

# Final message
neofetch
echo "You're all set up! welcome to LuminOS!"