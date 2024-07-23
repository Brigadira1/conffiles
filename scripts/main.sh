#/bin/bash

ARCH_PACKAGES_SCRIPT=add_arch_packages.sh
CUSTOM_CONF_SCRIPT=custom_conf_and_dot_files.sh

echo "Trying to source $ARCH_PACKAGES_SCRIPT and $CUSTOM_CONF_SCRIPT"

if [[ -f ./"${ARCH_PACKAGES_SCRIPT}"  &&  -x ./"${ARCH_PACKAGES_SCRIPT}"  && -f ./"${CUSTOM_CONF_SCRIPT}" && -x ./"${CUSTOM_CONF_SCRIPT}" ]]; then 
	. ./"${ARCH_PACKAGES_SCRIPT}" && . ./"${CUSTOM_CONF_SCRIPT}"
fi
