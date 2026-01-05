#!/bin/bash

mkdir ~/container # (Yes, thats important =3)
cd ~/container
git clone https://github.com/nixxlte/LuminOS
cd LuminOS && ls
sudo apt update && sudo apt upgrade
cp ~/container/LuminOS/Root/.bashrc ~/.bashrc
source ~/.bashrc
cd ..
git clone https://github.com/nixxlte/LuminCORE
cd LuminCORE/System/Modifications
cp extensions.md ~/container