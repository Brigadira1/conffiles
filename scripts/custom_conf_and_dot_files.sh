#!/usr/bin/env bash

echo "Configuring ./config directory ...."

CURRENT_DIR=$HOME/repos/conffiles/scripts/
CURRENT_CONFIG_DIR=test_config

configure_config_dir() {

    delete_old_configs
    # copy_new_configs

}

delete_old_configs() {

    echo "Deleting $HOME/$CURRENT_CONFIG_DIR/alacritty/ directory"
    rm -rf "$HOME/$CURRENT_CONFIG_DIR/alacritty/"

    echo "Deleting $HOME/$CURRENT_CONFIG_DIR/nvim/ directory"
    rm -rf "$HOME/$CURRENT_CONFIG_DIR/nvim/"

    echo "Deleting $HOME/$CURRENT_CONFIG_DIR/rofi/ directory"
    rm -rf "$HOME/$CURRENT_CONFIG_DIR/rofi/"

    echo "Deleting $HOME/$CURRENT_CONFIG_DIR/vifm/ directory"
    rm -rf "$HOME/$CURRENT_CONFIG_DIR/vifm/"

    echo "Deleting $HOME/$CURRENT_CONFIG_DIR/picom/ directory"
    rm -rf "$HOME/$CURRENT_CONFIG_DIR/picom"

    echo "Deleting $HOME/$CURRENT_CONFIG_DIR/qtile/ directory"
    rm -rf "$HOME/$CURRENT_CONFIG_DIR/qtile"

    echo "Deleting $HOME/$CURRENT_CONFIG_DIR/starship/ directory"
    rm -rf "$HOME/$CURRENT_CONFIG_DIR/starship"
}

copy_new_configs() {

    cd ..

    echo "The new working directory is $(pwd)"

    echo "Copying $(pwd)/alacritty to $HOME/$CURRENT_CONFIG_DIR/alacritty/"
    cp -rf ./alacritty "$HOME/$CURRENT_CONFIG_DIR/"

    echo "Copying $(pwd)/NvChad to $HOME/$CURRENT_CONFIG_DIR/nvim"
    cp -rf ./NvChad/nvim "$HOME/$CURRENT_CONFIG_DIR/"

    echo "Copying $(pwd)/rofi to $HOME/$CURRENT_CONFIG_DIR/rofi/"
    cp -rf ./rofi "$HOME/$CURRENT_CONFIG_DIR/"

    echo "Copying $(pwd)/vifm to $HOME/$CURRENT_CONFIG_DIR/vifm"
    cp -rf ./vifm "$HOME/$CURRENT_CONFIG_DIR/"

    echo "Copying $(pwd)/picom to $HOME/$CURRENT_CONFIG_DIR/picom"
    cp -rf ./picom "$HOME/$CURRENT_CONFIG_DIR/"

    echo "Copying $(pwd)/qtile to $HOME/$CURRENT_CONFIG_DIR/qtile"
    cp -rf ./qtile "$HOME/$CURRENT_CONFIG_DIR/"

    echo "Copying $(pwd)/starship to $HOME/$CURRENT_CONFIG_DIR/starship"
    cp -rf ./starship "$HOME/$CURRENT_CONFIG_DIR/"
}
configure_config_dir
