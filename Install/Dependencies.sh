#!/bin/bash

# Simple warn, i wont make any verifications for this script yet. also, almost every instalation command that exists here
# i found on the official websites.

# this script can run on any debian-based distro, cause it doesnt verify anything. it just wont run on other distros cause
# this sctipt uses APT/Nala

# and LAST, i made this thing to work in cubic, so it wont appear on the official iso files, in that case, dependencies will already be solved
# i dont grant this will work on VM's (virtual machines) or in real PCs.

# Code by Nix UwU
# Last thing, promisse, im coding this crap at almost 1 a.m, so i probably wrote something wrong (sorry, im sleepy)
# so ill fix this comments in about 1 week :3

sudo apt update && sudo apt upgrade -y

# Install dependencies for LuminSDK, including Avalonia and dotnet
#   dotnet -- commands from learn.microsoft.com
sudo su
apt install zlib1g
add-apt repository ppa:dotnet/backports
apt update
apt-get install -y dotnet-sdk-10.0 aspnetcore-runtime-10.0 dotnet-runtime-10.0
#   avalonia -- commands from docs.avaloniaui.net
dotnet nuget add source https://api.nuget.org/v3/index.json -n nuget.org
dotnet new install Avalonia.Templates
