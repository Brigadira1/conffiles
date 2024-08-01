#!/usr/bin/env bash

declare -A HOME_DOT_FILES


BASHRC="$HOME/.bashrc"
XINITRC="$HOME/.xinitrc"
XPROFILE="$HOME/.xprofile"
XRESOURCES="$HOME/.Xresources"

HOME_DOT_FILES[$BASHRC]=$(cat <<'EOF'
alias ll='lsd -alF'
alias la='lsd -A'
alias ls='lsd -al'
alias vim='nvim'
export EDITOR=nvim
export XDG_CONFIG_HOME=/home/brigadira/.config
export PATH="$XDG_CONFIG_HOME:$PATH"
colorscript random
eval "$(starship init bash)"
EOF
)

HOME_DOT_FILES[$XPROFILE]=$(cat <<'EOF'
nitrogen --restore --set-zoom-fill &
setxkbmap -model pc104 -layout us,bg -variant ,phonetic -option grp:win_space_toggle &
picom --config /home/brigadira/.config/picom/picom.conf -f &
EOF
)

HOME_DOT_FILES[$XINITRC]=$(cat <<'EOF'
nitrogen --restore --set-zoom-fill &
setxkbmap -model pc104 -layout us,bg -variant ,phonetic -option grp:win_space_toggle &
xrandr --dpi 109 &
picom -f &
exec qtile start
EOF
)

HOME_DOT_FILES[$XRESOURCES]="Xft.dpi: 109"

backup_dot_files() {

    for file in "${!HOME_DOT_FILES[@]}"; do
        if [ -f "$file" ]; then
            echo "$file file exists. Taking a backup..."
            cp -f "$file" "${file}.backup_$(date +%d%m%Y_%H%M%S)"
        else
            echo "$file doesn't exist. No backup was taken."
            check_dot_files_existence $file
        fi
    done

}

line_exists() {

    local file=$1
    local line=$2
    grep -Fxq "$2" "$file"

}

add_line_to_file() {

    local file=$1
    local lines="${HOME_DOT_FILES[$file]}"

    while IFS= read -r line; do
        if [ -n "$line" ]; then
            if ! line_exists "$file" "$line"; then
                echo "Adding: $line in $file"
                echo "$line" >> "$file"
            else
                echo "Skipping (already exists): $line in $file"
            fi
        fi
    done <<< "$lines"

}
add_all_lines_to_all_files() {

    backup_dot_files
    for file in "${!HOME_DOT_FILES[@]}"; do
        add_line_to_file "$file"
        echo "############################################################################################################################"
    done

}

check_dot_files_existence() {

    local file=$1
    echo "Processing file: $file"

    if [[ $file == *".xinitrc"* ]]; then
        if [ ! -f "$file" ]; then
            echo "Copying /etc/X11/xinit/xinitrc to $file"
            cp -f /etc/X11/xinit/xinitrc ~/.xinitrc
        fi
    elif [ ! -f "$file" ]; then
        echo "File $file doesn't exist. Creating it in home directory."
        touch "$file"
    fi
        
}

add_all_lines_to_all_files
