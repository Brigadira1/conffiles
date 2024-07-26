#!/usr/bin/env bash

declare -A HOME_DOT_FILES


BASHRC="$HOME/.bashrc"
XINITRC="$HOME/.xinitrc"
XPROFILE="$HOME/.xprofile"
XRESOURCES="$HOME/.Xresources"

HOME_DOT_FILES[$BASHRC]=(
    "alias ll='lsd -alF'"
    "alias la='lsd -A'"
    "alias ls='lsd -al'"
    "alias vim='nvim'"
    "export EDITOR=nvim"
    "export XDG_CONFIG_HOME=/home/brigadira/.config"
    'export PATH="$XDG_CONFIG_HOME:$PATH"'
    "colorscript random"
    'eval "$(starship init bash)"'
)

HOME_DOT_FILES[$XPROFILE]=(
    "nitrogen --restore --set-zoom-fill &"
    "setxkbmap -model pc104 -layout us,bg -variant ,phonetic -option grp:win_space_toggle &"
    "picom --config /home/brigadira/.config/picom/picom.conf -f &"
)

HOME_DOT_FILES[$XINITRC]=(
    "nitrogen --restore --set-zoom-fill &"
    "setxkbmap -model pc104 -layout us,bg -variant ,phonetic -option grp:win_space_toggle &"
    "xrandr --dpi 109 &"
    "picom -f &"
    "exec qtile start"
)

HOME_DOT_FILES[$XRESOURCES]=(
    "Xft.dpi:109"
)

DOT_FILES=(
    BASHRC
    XINITRC
    XPROFILE
    )

backup_dot_files() {

    for file in "${DOT_FILES[@]}"; do
        if [ -f "$file" ]; then
            echo "$file file exists. Taking a backup..."
            cp -f "$file" "$file_$(date +%D%M%Y_%H%M%S)"
        else
            echo "$file doesn't exist. No backup was taken."
        fi
    done

}

line_exists() {

    local file=$1
    local line=$2
    grep -Fxq "$2" "$file"

}

add_line() {

    

}



