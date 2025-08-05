#@TYPE: Machine Include
#@NAME: Optologic Display support for Toradex boards
#@DESCRIPTION: Adds support for Optologic Displays on Toradex starter kit with the Verdin and Colibri SoMs.
#@MAINTAINER: OPTO Logic TECHNOLOGY S.A. <support@optologic.ch>

# Build the Optologic Display overlays for Toradex SoMs
MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "device-tree-overlays-optologic"

# List of Optologic overlays to compile and include in the image.
# Relies on using a MACHINE as defined by Toradex, like the other Toradex
# kernel recipes rely on. This assignment doesn't support custom MACHINE names.
# https://developer.toradex.com/linux-bsp/os-development/build-yocto/custom-meta-layers-recipes-and-images-in-yocto-project-hello-world-examples#add-a-custom-kernel-configuration
OPTOLOGIC_DEVICETREE_OVERLAYS ?= " \
    ${MACHINE}_optologic_panel-cap-touch-7inch-lvds_overlay.dtbo \
    "

# Choose the OPTO logic Display to load at boot time by assigning this variable.
OPTOLOGIC_DEVICETREE_OVERLAYS_BOOT ?= "${MACHINE}_optologic_panel-cap-touch-7inch-lvds_overlay.dtbo"
