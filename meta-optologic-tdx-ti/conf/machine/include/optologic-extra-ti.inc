#@TYPE: Machine Include
#@NAME: Optologic Display support for Toradex boards
#@DESCRIPTION: Adds support for Optologic Displays on Toradex starter kit with the TI SoMs.
#@MAINTAINER: OPTO Logic TECHNOLOGY S.A. <support@optologic.ch>

# Build the Optologic Display overlays for Toradex TI SoMs
MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "device-tree-overlays-optologic-ti"
