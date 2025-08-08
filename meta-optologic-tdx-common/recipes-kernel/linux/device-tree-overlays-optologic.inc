SUMMARY = "Device tree overlays for OPTO Logic accessories on Toradex modules"
HOMEPAGE = "https://github.com/optologic/device-tree-overlays-optologic"
# SECTION,LICENSE provided by devicetree.bbclass

# OPTO Logic device tree overlays for Toradex modules to be built and included
# in the image. (defined in optologic-extra.inc)
OPTOLOGIC_DEVICETREE_OVERLAYS ??= ""

inherit toradex-devicetree

# Redefine PROVIDES to avoid conflict on the virtual/dtb package
# Allows to compile both the Toradex overlays and the Optologic overlays
# Our recipe doesn't want to replace the main dtb virtual package
# but rather provide additional overlays.
PROVIDES = "${PN}"

S = "${WORKDIR}/git"

SRC_URI = "git://github.com/optologic/device-tree-overlays-optologic.git;protocol=https;branch=${SRCBRANCH}"

TEZI_EXTERNAL_KERNEL_DEVICETREE = "${OPTOLOGIC_DEVICETREE_OVERLAYS}"

# The overlays.txt file will be overwritten by device-tree-overlays-ti
# Remove it to avoid packaging conflicts
TEZI_EXTERNAL_KERNEL_DEVICETREE_BOOT = ""
do_deploy:append() {
    rm -f ${DEPLOYDIR}/overlays.txt
}
