#!/bin/bash

PACKAGES="" 
AUR_PACKAGES=""
INSTALLER_OPTIONS=" --needed --noconfirm" 

install_pacman_packages() {

  PACKAGES+="base-devel qemu-guest-agent git lshw openssh xrdp lxappearance arc-gtk-theme wget curl rsync neovim xclip gzip zip unzip libx11 libxft harfbuzz libxinerama cups hplip ntp nfs-utils cifs-utils htop net-tools vifm plocate bash-completion lsd alacritty starship xorg-xrandr python python-pip python-psutil network-manager-applet reflector linux  -headers tree less rofi picom nitrogen hwinfo glibc linux-headers"

  echo "Executing pacman with a preconfigured list of packages...."
  sudo pacman -S $PACKAGES $INSTALLER_OPTIONS
}

install_yay_packages() {
  AUR_PACKAGES+="brave-bin xorg-xdpyinfo xorgxrdp-nvidia papirus-icon-theme-gi qtile-extras nomachine pavucontrol qt5ctarchlinux-tweak-tool-git xorgxrdp-nvidia"

  install_yay
  echo "Executing yay with a preconfigured list of packages...."
  yay -S $AUR_PACKAGES $INSTALLER_OPTIONS
}

install_yay() {
    # Update the system
    echo "Updating system..."
    sudo pacman -Syu --noconfirm

    # Install base-devel and git if not already installed
    echo "Installing base-devel and git..."
    sudo pacman -S --needed base-devel git --noconfirm

    # Create a temporary directory
    temp_dir=$(mktemp -d)
    cd "$temp_dir"

    # Download PKGBUILD
    echo "Downloading yay PKGBUILD..."
    curl -O https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=yay

    # Build and install yay
    echo "Building and installing yay..."
    makepkg -si --noconfirm

    # Clean up
    cd
    rm -rf "$temp_dir"

    echo "yay has been installed successfully!"
}
configure_services() {

  echo "Enabling sshd service..."
  sudo systemctl enable --now sshd

  echo "Enabling xrdp service..."
  sudo systemctl enable --now xrdp

  echo "Enabling printer service..."
  sudo systemctl enable --now cups.service

  # echo "Enabling time sync service..."
  # sudo systemctl enable --now ntpd

  echo "Enabling NoMachine service..."
  sudo systemctl enable --now nxserver.service

  echo "Adding Bulgaria as the location for the mirror list of repositories..."
  sudo reflector --country Bulgaria --age 6 --sort rate --save /etc/pacman.d/mirrorlist
  echo "Enabling the reflector service..."
  sudo systemctl enable --now reflector.timer
}

install_pacman_packages
install_yay_packages
configure_services
