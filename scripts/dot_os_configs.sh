#!/usr/bin/env bash

declare -A HOME_DOT_FILES
declare -A HOME_DOT_FILES_REMOVE_LINES

IS_BACKUP_TAKEN=0

BASHRC="$HOME/.bashrc"
XINITRC="$HOME/.xinitrc"
XPROFILE="$HOME/.xprofile"
XRESOURCES="$HOME/.Xresources"
BASH_PROFILE="$HOME/.bash_profile"



HOME_DOT_FILES[$BASHRC]=$(cat <<'EOF'
alias ll="eza --color=always --all --group-directories-first --long --git --icons=always"
alias ls="eza --color=always --all --group-directories-first --long --no-time --git --icons=always"
alias tree="eza --tree"
alias cd="z"
alias vim='nvim'
alias cat='bat'

export EDITOR=nvim
export XDG_CONFIG_HOME=/home/brigadira/.config
export PATH="$XDG_CONFIG_HOME:$PATH"
export QT_QPA_PLATFORMTHEME=qt5ct
export GTK_THEME=Arc-Dark:dark
export STARSHIP_CONFIG=~/.config/starship/starship.toml

shopt -s histappend
export PROMPT_COMMAND='history -a'
export HISTCONTROL=ignoreboth
export HISTSIZE=3000
export HISTFILESIZE=10000

bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

eval "$(fzf --bash)"
# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/repos/fzf-git.sh/fzf-git.sh
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ----- Bat (better cat) -----
export BAT_THEME=tokyonight_night

# ---- Zoxide (better cd) ----
eval "$(zoxide init bash)"

eval "$(starship init bash)"
set -o vi
colorscript random
EOF
)

HOME_DOT_FILES[$BASH_PROFILE]=$(cat <<'EOF'
if [[ "$(tty)" == "/dev/tty1" ]]; then
    startx
fi
EOF
)

HOME_DOT_FILES[$XPROFILE]=$(cat <<'EOF'
nitrogen --random --set-zoom-fill ~/.config/wallpapers/ &
setxkbmap -model pc104 -layout us,bg -variant ,phonetic -option grp:win_space_toggle &
# picom --config /home/brigadira/.config/picom/picom.conf -f &
# xrandr --output Virtual-1 --mode "2560x1440_60.00" --dpi 109 &
picom -f &
nvidia-settings -a CurrentMetaMode="DPY-2: nvidia-auto-select @2560x1440 +0+0 {ViewPortIn=2560x1440, ViewPortOut=3840x2160+0+0}"
EOF
)

HOME_DOT_FILES[$XINITRC]=$(cat <<'EOF'
nitrogen --random --set-zoom-fill ~/.config/wallpapers/ &
setxkbmap -model pc104 -layout us,bg -variant ,phonetic -option grp:win_space_toggle &
# xrandr --output Virtual-1 --mode "2560x1440_60.00" --dpi 109 &
picom -f &
exec qtile start
EOF
)

HOME_DOT_FILES_REMOVE_LINES[$XINITRC]=$(cat <<'EOF'
twm &
xclock -geometry 50x50-1+1 &
xterm -geometry 80x50+494+51 &
xterm -geometry 80x20+494-0 &
exec xterm -geometry 80x66+0+0 -name login
EOF
)


HOME_DOT_FILES[$XRESOURCES]="Xft.dpi: 109"

backup_dot_files() {

    local backup_dir="$HOME/backup/dotfiles"
    if [ ! -d "$backup_dir" ]; then
        mkdir -p "$backup_dir"
    fi

    for file in "${!HOME_DOT_FILES[@]}"; do
        if [ -f "$file" ]; then
            echo "$file file exists. Taking a backup..."
            local timestamp=$(date +%d%m%Y_%H%M%S)
            cp -f "$file" "$file.backup_$timestamp"
            echo "Moving $file.backup_$timestamp to $backup_dir..."
            mv "$file.backup_$timestamp" "$backup_dir"
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

modify_single_line() {

    local file=$1
    local operation=$2
    local lines=$3

    while IFS= read -r line; do
        if [ -n "$line" ]; then
            if [ "$operation" = "add" ]; then
                if ! line_exists "$file" "$line"; then
                    echo "Adding: $line in $file"
                    echo "$line" >> "$file"
                else
                    echo "Skipping (already exists): $line in $file"
                fi
            elif [ "$operation" = "delete" ]; then
                echo "Removing '$line' from '$file'..."
                sed -i "/$line/d" "$file"
            else
                echo "Invalid operation specified. Exiting..."
                return 1
            fi
        fi
    done <<< "$lines"

}

modify_all_lines_to_all_files() {

    local operation=$1
    local -n as_array=$2

    if [ "$IS_BACKUP_TAKEN" -eq 0 ]; then
        backup_dot_files
        IS_BACKUP_TAKEN=1
    fi
    for file in "${!as_array[@]}"; do
        modify_single_line "$file" "$operation" "${as_array[$file]}"
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

modify_all_lines_to_all_files "add" HOME_DOT_FILES 
modify_all_lines_to_all_files "delete" HOME_DOT_FILES_REMOVE_LINES 
