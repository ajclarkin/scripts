#! /bin/bash

# This is for a new server
# Run it from home directory

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

# Get the username for use later
username=$(id -u -n 1000)

# Update the system
apt update
apt upgrade -y


# Install nala - nicer interface to APT
apt install nala -y



# Install Neovim (Interactive)
echo "Install Neovim and configuration files? (y/n)"
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo "Installing Neovim..."
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    mv nvim.appimage /usr/local/bin/

    mkdir -p .config/
    git clone git@github.com:ajclarkin/neovim-config.git
    mv neovim-config nvim
    mv nvim .config/
    
fi



# Install Docker (Interactive)
echo "Install Docker? (y/n)"
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo "Installing Docker..."
    curl -sSL https://get.docker.com/ | sh

    # Enable non-root access to Docker
    sudo usermod -aG docker $username
    
fi
