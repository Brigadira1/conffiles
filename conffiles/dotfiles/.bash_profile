#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# comment this part if you invoke your WM with Display Manager like LightDM or SDDM
if [[ "$(tty)" == "/dev/tty1" ]]; then
	startx
fi

