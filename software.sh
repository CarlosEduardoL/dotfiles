#!/usr/bin/env bash

# Check if user is root
SUDO=''
if [ "$EUID" -ne 0 ]; then
    # Check if sudo is installed
    if ! [ -x "$(command -v sudo)" ]; then
        >&2 echo "Sudo is required. Please install it."
        exit 1
    fi
    SUDO='sudo'
fi

# Detect package manager and install packages
if [ -x "$(command -v apt-get)" ]; then
    $SUDO apt-get update
    dpkg -l build-essential cmake zsh curl zip unzip git &> /dev/null || $SUDO apt-get install build-essential cmake zsh curl zip unzip git -y
elif [ -x "$(command -v dnf)" ]; then
    dnf grouplist installed | grep -q 'Development Tools' || $SUDO dnf groupinstall 'Development Tools'
    rpm -q cmake zsh curl zip unzip gcc-c++ git &> /dev/null || $SUDO dnf install cmake zsh curl zip unzip gcc-c++ git -y
elif [ -x "$(command -v yum)" ]; then
    yum grouplist installed | grep -q 'Development Tools' || $SUDO yum groupinstall 'Development Tools'
    rpm -q cmake zsh curl zip unzip gcc-c++ git &> /dev/null || $SUDO yum install cmake zsh curl zip unzip gcc-c++ git -y
elif [ -x "$(command -v pacman)" ]; then
    pacman -Qi base-devel cmake zsh curl zip unzip git &> /dev/null || $SUDO pacman -Syu --noconfirm base-devel cmake zsh curl zip unzip git
elif [ -x "$(command -v brew)" ]; then
    brew list cmake zsh curl git &> /dev/null || brew install cmake zsh curl git # Not tested
else
    echo "Package manager not found"
    exit 1
fi