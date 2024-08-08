#!/usr/bin/env bash

blacklist_nouveau() {

    local nouveau_options=("blacklist nouveau" "options nouveau modeset=0")
    local nouveau_blacklist_conf="/etc/modprobe.d/blacklist-nouveau.conf"

    echo "Checking to see if nouveau driver is blacklisted..."
    if [ ! -f "$nouveau_blacklist_conf" ]; then
        echo "Nouveau driver is not blacklisted. Blacklisting it now..."
        touch "$nouveau_blacklist_conf"

        echo "Adding ${nouveau_options[0]}"
        echo "${nouveau_options[0]}" >> "$nouveau_blacklist_conf"

        echo "Adding ${nouveau_options[1]}"
        echo "${nouveau_options[1]}" >> "$nouveau_blacklist_conf"
        return 0
    fi
    if search_strings_in_file "${nouveau_options[@]}" "$nouveau_blacklist_conf"; then
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

    echo "Setting nvidia_drm modeset to 1...."
    if [ ! -f "$modeset_conf" ]; then
        touch "$modeset_conf"
        echo "${drm_modeset[0]}" >> "$modeset_conf"
        return 0
    fi
    if search_strings_in_file "${drm_modeset[@]}" "$modeset_conf"; then
        echo "Nvidia_drm modeset=1 was already set."
        return 0
    else
        echo "File '$modeset_conf' found but the entries in it are wrong!"
        return 1
    fi

}

search_strings_in_file() {

    local list_of_strings=$1
    local file=$2

    if [ ${#list_of_strings[@]} -gt 0 ]; then
        for string in "${list_of_strings[@]}"; do
            echo "Checking whether '$string' is contained in '$file'"
            if ! grep -Fxq "$string" "$file"; then
                echo "'$string' was not found in '$file'!"
                return 1
            fi
        done
    fi
    echo "All strings were found in '$file'"
    return 0

}
