#!/usr/bin/env bash

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

blacklist_nouveau
enable_drm_kernel_mode
