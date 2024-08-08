#!/usr/bin/env bash

PACKAGES="" 
INSTALLER_OPTIONS=" --needed --noconfirm" 


initialize_packages() {

    local base_packages="base-devel glibc linux-headers"
    local xorg_packages=" xorg-server libx11 xorg-xrandr xorg-xinit xorg-xdpyinfo xrdp"
    local tools_packages=" qemu-guest-agent git lshw openssh openvpn pavucontrol plocate wget curl rsync nfs-utils cifs-utils htop net-tools tree less hwinfo qt5ct"
    local themes_packages=" lxappearance arc-gtk-theme papirus-icon-theme-git"
    local shell_packages=" bash-completion lsd alacritty starship shell-color-scripts-git"
    local compress_packages=" gzip zip unzip"
    local helper_packages=" libxft harfbuzz libxinerama network-manager-applet reflector man"
    local printer_packages=" cups hplip"
    # local piperwire_packages=" alsa-utils pipewire pipewire-alsa pipewire-jack pipewire-pulse pipewire-module-xrdp-git sof-firmware"
    local pulseaudio=" pulseaudio"
    local python_packages=" python python-pip python-psutil"
    local neovim_packages=" neovim xclip"
    local core_packages=" vifm rofi picom nitrogen brave-bin nomachine"
    local qtile_packages=" qtile qtile-extras"
    local nvidia_packages=" nvidia nvidia-utils nvidia-settings nvtop"
    local basic_lightdm_packages=" lightdm-gtk-greeter lightdm"
    # local advanced_lightdm_packages=" lightdm lightdm-webkit-theme-aether"

    PACKAGES+=$base_packages
    PACKAGES+=$xorg_packages
    PACKAGES+=$tools_packages
    PACKAGES+=$themes_packages
    PACKAGES+=$shell_packages
    PACKAGES+=$compress_packages
    PACKAGES+=$helper_packages
    PACKAGES+=$printer_packages
    # PACKAGES+=$piperwire_packages
    PACKAGES+=$pulseaudio
    PACKAGES+=$python_packages
    PACKAGES+=$neovim_packages
    PACKAGES+=$core_packages
    PACKAGES+=$qtile_packages
    PACKAGES+=$nvidia_packages
    PACKAGES+=$basic_lightdm_packages

    echo
    echo -e "All the packages were assembled:\n\n$PACKAGES"
}

install_all_packages() {
    if [ -z "$PACKAGES" ]; then
        echo "The packages list is empty: PACKAGES=$PACKAGES"
        exit 1
    fi
    
    for s_package in $PACKAGES; do
        install_single_package "$s_package"
    done


}

install_single_package() {

    local package=$1

    if is_official_package $package; then
        echo
        echo "Installing $package with pacman"
        sudo pacman -S $INSTALLER_OPTIONS $package
    else
        if ! command -v yay &> /dev/null; then
            install_yay
        fi
        echo
        echo "Installing $package with yay"
        yay -S $INSTALLER_OPTIONS $package
    fi
}

is_official_package() {

    local package_name="$1"

    if pacman -Si $package_name &> /dev/null; then
        return 0
    else
        return 1
    fi

}

install_yay() {

    # Install base-devel and git if not already installed
    echo "Installing base-devel and git..."
    sudo pacman -S base-devel git $INSTALLER_OPTIONS :

    # Create a temporary directory
    (
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
    )

}

configure_services() {

    echo
    echo "Enabling sshd service..."
    sudo systemctl enable --now sshd

    echo
    echo "Enabling xrdp service..."
    sudo systemctl enable --now xrdp

    echo
    echo "Enabling printer service..."
    sudo systemctl enable --now cups.service

    echo
    echo "Enabling NoMachine service..."
    sudo systemctl enable --now nxserver.service
    sudo /etc/NX/nxserver --restart nxd

    echo
    echo "Enabling Pulseaudio services..."
    # systemctl --user --now enable pipewire pipewire-pulse wireplumber
    sudo systemctl enable --global pulseaudio
    sudo /usr/NX/scripts/setup/nxnode --audiosetup

    echo
    echo "Enabling Lightdm services..."
    sudo systemctl enable --now lightdm.service
 
}

install_hack_nerd() {

    echo "Starting installation of Hack Nerd font family..."
    sudo pacman -S $INSTALLER_OPTIONS ttf-hack-nerd
    fc-cache -v 

}

configure_reflector() {

    echo "Adding Bulgaria as the location for the mirror list of repositories..."
    sudo reflector -c Bulgaria --save /etc/pacman.d/mirrorlist
    echo "Enabling the reflector service..."
    sudo systemctl enable --now reflector.timer

}

upgrade_os() {

    echo
    echo "Upgrading the Arch OS first!!!"
    sudo pacman -Syu
    echo
    echo "Arch OS successfully upgraded"

}

upgrade_os
initialize_packages
yay -R pipewire-pulse --noconfirm 
install_all_packages
configure_services
install_hack_nerd
