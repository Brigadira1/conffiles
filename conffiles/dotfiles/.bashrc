#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#################################################################################################### CUSTOM ALIASES #####################################################################################################
# some more ls aliases
alias ll='lsd -alF'
alias la='lsd -A'
alias ls='lsd -al'

alias vim='nvim'
#################################################################################################### CUSTOM ALIASES #####################################################################################################

alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export EDITOR=nvim
export XDG_CONFIG_HOME=/home/brigadira/.config
export PATH="$XDG_CONFIG_HOME:$PATH"
# The color scripts of Derek Taylor
colorscript random
# Starship command prompt
eval "$(starship init bash)"
