#!/usr/bin/env bash

echo "Configuring ./config directory ...."

CURRENT_DIR=$HOME/repos/conffiles/scripts/
CURRENT_CONFIG_DIR=$HOME/.config
CONFIG_DIR_APPS="alacritty nvim rofi vifm picom qtile starship"
IS_BACKUP_TAKEN=false

configure_apps_dir() {

    handle_app_configs backup
    handle_app_configs delete
    handle_app_configs copy

}

backup_app_config() {

    local app_folder=$1

    if [ ! -d $CURRENT_CONFIG_DIR/backup ]; then
        echo "Backup directory doesn't exist ..."
        echo "Creating backup directory in $CURRENT_CONFIG_DIR/backup ..."
        mkdir -p "$CURRENT_CONFIG_DIR/backup"
    fi
    
    if [[ -d $CURRENT_CONFIG_DIR/$app_folder && $IS_BACKUP_TAKEN == "false" ]]; then
        echo "Backing up $CURRENT_CONFIG_DIR/$app_folder ..."
        cp -rf "$CURRENT_CONFIG_DIR/$app_folder" "$CURRENT_CONFIG_DIR/backup"
    fi

}


delete_old_config() {

    local app_folder=$1
    backup_app_config $app_folder
    
    if [ -d $CURRENT_CONFIG_DIR/$app_folder ]; then
        echo "Deleting $CURRENT_CONFIG_DIR/$app_folder ..."
        rm -rf $CURRENT_CONFIG_DIR/$app_folder
    fi

}

copy_new_config() {

    local app_folder=$1

    delete_old_config app_folder
    (
        cd ..
        echo "Copying from $(pwd)/$app_folder to $CURRENT_CONFIG_DIR"
        cp -rf "./$app_folder" "$CURRENT_CONFIG_DIR"
    )

}

handle_app_configs() {

    local action="$1"
    for app in $CONFIG_DIR_APPS; do
        if [[ $action == "backup" ]]; then
            backup_app_config $app
        elif [[ $action == "delete" ]]; then
            delete_old_config $app
        elif [[ $action == "copy" ]]; then
            copy_new_config $app
        else
            echo "The only possible actions are: backup, delete or copy"
            echo "You've specified invalid action: $action "
        fi
    done
    IS_BACKUP_TAKEN=true
}

handle_starship_conf() {

    echo "Coping $CURRENT_CONFIG_DIR/starship/starship.toml into $CURRENT_CONFIG_DIR"
    cp -rf "$CURRENT_CONFIG_DIR/starship/starship.toml" "$CURRENT_CONFIG_DIR/"

}

configure_apps_dir
handle_starship_conf
