#!/bin/bash

mkdir ~/container # (Yes, thats important =3)
git clone https://github.com/nixxlte/LuminOS
cd LuminOS && ls
sudo apt update && sudo apt upgrade
cp ~/container/LuminOS/Root/.bashrc ~/.bashrc
source ~/.bashrc