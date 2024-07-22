#!/bin/bash

PACKAGES="" 
AUR_PACKAGES=""
INSTALLER_OPTIONS=" --needed --noconfirm" 

install_pacman_packages() {

  PACKAGES+="qemu-guest-agent git lshw openssh xrdp lxappearance arc-gtk-theme wget curl rsync neovim xclip gzip zip unzip libx11 libxft harfbuzz libxinerama cups hplip ntp nfs-utils cifs-utils htop net-tools vifm plocate bash-completion lsd alacritty starship xorg-xrandr python python-pip python-psutil network-manager-applet reflector linux  -headers tree less rofi picom nitrogen hwinfo glibc linux-headers"

  echo "Executing pacman with a preconfigured list of packages...."
  pacman -S $PACKAGES $INSTALLER_OPTIONS
}

install_yay_packages() {
  AUR_PACKAGES+="brave-bin xorg-xdpyinfo xorgxrdp-nvidia papirus-icon-theme-gi qtile-extras nomachine pavucontrol qt5ctarchlinux-tweak-tool-git xorgxrdp-nvidia"

  install_yay
  echo "Executing yay with a preconfigured list of packages...."
  yay -S $AUR_PACKAGES $INSTALLER_OPTIONS
}

install_yay() {
    sudo pacman -Syu $INSTALLER_OPTIONS
    sudo pacman -S curl $INSTALLER_OPTIONS 
    mkdir -p ~/repos/yay
    cd ~/repos/yay

    curl -OJ 'https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=yay'
    makepkg si
    cd
    rm -rf ~/repos/yay
    echo "yay versions is: $(yay --version)"
}
configure_services() {

  echo "Enabling sshd service..."
  systemctl enable --now sshd

  echo "Enabling xrdp service..."
  systemctl enable --now xrdp

  echo "Enabling printer service..."
  systemctl enable --now cups.service

  echo "Enabling time sync service..."
  systemctl enable --now ntpd

  echo "Enabling NoMachine service..."
  systemctl enable --now nxserver.service

  echo "Adding Bulgaria as the location for the mirror list of repositories..."
  reflector --country Bulgaria --age 6 --sort rate --save /etc/pacman.d/mirrorlist
  echo "Enabling the reflector service..."
  systemctl enable --now reflector.timer
}

install_pacman_packages
install_yay_packages
configure_services



