#!/usr/bin/env bash

SINGLE_GPU_CONF_FILE="$HOME/repos/conffiles/X11/gpu-accelerated/xorgconf/20-nvidia.conf"
XORG_CONF_FILE="$HOME/repos/conffiles/X11/gpu-accelerated/xorgconf/xorg.conf.newest"
XORG_DIR="/etc/X11"
XORG_CONF_DIR="/etc/X11/xorg.conf.d"
NVIDIA_MODULES_FILE="/etc/mkinitcpio.conf"

blacklist_nouveau() {

    local nouveau_options=("blacklist nouveau" "options nouveau modeset=0")
    local nouveau_blacklist_conf="/etc/modprobe.d/blacklist-nouveau.conf"

    echo "Checking to see if nouveau driver is blacklisted..."
    if [ ! -f "$nouveau_blacklist_conf" ]; then
        echo "Nouveau driver is not blacklisted. Blacklisting it now..."
        sudo touch "$nouveau_blacklist_conf"
        echo "Adding '${nouveau_options[0]}' entry."
        echo "${nouveau_options[0]}" | sudo tee -a "$nouveau_blacklist_conf" > /dev/null
        echo "Adding '${nouveau_options[1]}' entry."
        echo "${nouveau_options[1]}" | sudo tee -a "$nouveau_blacklist_conf" > /dev/null
        return 0
    fi
    echo "$nouveau_blacklist_conf exists and will not be created."
    if search_strings_in_file "$nouveau_blacklist_conf" "${nouveau_options[@]}"; then
        echo "Nouveau driver already blacklisted. Nothing to do...."
        return 0
    else
        echo "File $nouveau_blacklist_conf found but the entries in it are wrong!"
        return 1
    fi
    regenerate_initramfs
}

enable_drm_kernel_mode() {

    local drm_modeset=("options nvidia_drm modeset=1") 
    local modeset_conf="/etc/modprobe.d/modeset.conf"

    echo "Checking to see whether /etc/modprobe.d/modeset.conf exists..."
    if [ ! -f "$modeset_conf" ]; then
        sudo touch "$modeset_conf"
        echo "modeset.conf didn't exist and was created."
        echo "Setting nvidia_drm modeset to 1...."
        echo "${drm_modeset[0]}" | sudo tee -a "$modeset_conf" > /dev/null
        return 0
    fi
    if search_strings_in_file "$modeset_conf" "${drm_modeset[*]}"; then
        echo "Nvidia_drm modeset=1 was already set."
        return 0
    else
        echo "File '$modeset_conf' found but the entries in it are wrong!"
        return 1
    fi
    regenerate_initramfs

}

search_strings_in_file() {

    local file=$1
    shift
    local list_of_strings=("$@")

    if [ ${#list_of_strings[@]} -gt 0 ]; then
        for string in "${list_of_strings[@]}"; do
            echo "Checking whether '$string' is contained in '$file'"
            if ! sudo grep -Fxq "$string" "$file"; then
                echo "'$string' was not found in '$file'!"
                return 1
            fi
            echo "'$string' was found in '$file'."
        done
    else
        echo "The list of parameters is empty. Nothing to do..."
        return 1
    fi
    echo "All strings were found in '$file'"
    return 0

}

copy_Xorg_configs() {

    echo
    echo "Handling $XORG_CONF_FILE..."
    if [ -f "$XORG_DIR/xorg.conf" ]; then
        echo "$XORG_DIR/xorg.conf exists. Backing it up..."
        sudo cp -f "$XORG_DIR/xorg.conf" "$XORG_DIR/xorg.conf.bak"
    fi
    echo "Copying $XORG_CONF_FILE to $XORG_DIR/xorg.conf..."
    sudo cp -f "$XORG_CONF_FILE" "$XORG_DIR/xorg.conf"

    echo
    echo "Handling $SINGLE_GPU_CONF_FILE...."
    if [ -f "$XORG_CONF_DIR/20-nvidia.conf" ]; then
        echo "$XORG_CONF_DIR/20-nvidia.conf exists. Backing it up..."
        sudo cp -f "$XORG_CONF_DIR/20-nvidia.conf" "$XORG_CONF_DIR/20-nvidia.conf.bak"
    fi
    echo "Copying $SINGLE_GPU_CONF_FILE to $XORG_CONF_DIR directory..."
    sudo cp -f "$SINGLE_GPU_CONF_FILE" "$XORG_CONF_DIR"
}

regenerate_initramfs() {

    echo
    echo "Regenerating initramfs.."
    sudo mkinitcpio -P

}

load_nvidia_modules() {

    local file="$NVIDIA_MODULES_FILE"

    if [ ! -f "$file" ]; then
        echo
        echo "$file doesn't exist. Exiting..."
        return 1
    else
        echo
        echo "File $file exists. Taking a backup..."
        sudo cp "$file" "/etc/mkinitcpio.conf.bak"
    fi
    if ! grep -q "^MODULES=\(.*\)" "$file"; then
        echo
        echo "MODULES=(...) entry was not found in $file!. Exiting.."
        return 1
    else
        sudo sed -i 's/^MODULES=(.*)/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' "$file"
    fi
    regenerate_initramfs
}
blacklist_nouveau
enable_drm_kernel_mode
copy_Xorg_configs
load_nvidia_modules $NVIDIA_MODULES_FILE
sudo shutdown -h now
