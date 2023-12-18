#!/bin/sh
#   ___ _____ ___ _     _____   ____  _             _    
#  / _ \_   _|_ _| |   | ____| / ___|| |_ __ _ _ __| |_  
# | | | || |  | || |   |  _|   \___ \| __/ _` | '__| __| 
# | |_| || |  | || |___| |___   ___) | || (_| | |  | |_  
#  \__\_\|_| |___|_____|_____| |____/ \__\__,_|_|   \__| 
#                                                        
#  
# ----------------------------------------------------- 

# My screen resolution
# xrandr --rate 120

# For Virtual Machine 
# xrandr --output Virtual-1 --mode 1920x1080

# Set keyboard layout in config.py

# Load picom
nitrogen --restore --set-zoom-fill &
setxkbmap -model pc104 -layout us,bg -variant ,phonetic -option grp:win_space_toggle &
picom --config /home/brigadira/.config/picom/picom.conf -f &
