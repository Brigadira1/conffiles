#!/usr/bin/env bash

ARCH_PACKAGES_SCRIPT=add_arch_packages.sh
CUSTOM_CONF_SCRIPT=custom_apps_config.sh
DOT_OS_CONFIGS=dot_os_configs.sh
CURRENT_DIR=$(pwd)
echo "Trying to source $ARCH_PACKAGES_SCRIPT, $CUSTOM_CONF_SCRIPT and $DOT_OS_CONFIGS"

if [[ -f ./"${ARCH_PACKAGES_SCRIPT}"  &&  -x ./"${ARCH_PACKAGES_SCRIPT}"  && -f ./"${CUSTOM_CONF_SCRIPT}" && -x ./"${CUSTOM_CONF_SCRIPT}" && -f ./"${DOT_OS_CONFIGS}" && -x ./"${DOT_OS_CONFIGS}" ]]; then 
    . ./"${ARCH_PACKAGES_SCRIPT}" && . ./"${CUSTOM_CONF_SCRIPT}" && . ./"${DOT_OS_CONFIGS}"
fi
