SUMMARY = "Device tree overlays for OPTO Logic accessories on Toradex modules"
HOMEPAGE = "https://github.com/optologic/device-tree-overlays-optologic"
# SECTION,LICENSE provided by devicetree.bbclass

inherit toradex-devicetree

# Redefine PROVIDES to avoid conflict on the virtual/dtb package
# Allows to compile both the Toradex overlays and the Optologic overlays
# Our recipe doesn't want to replace the main dtb virtual package
# but rather provide additional overlays.
PROVIDES = "${PN}"

SRC_URI = "git://github.com/optologic/device-tree-overlays-optologic.git;protocol=https;branch=main"

SRCBRANCH_TI = "linux-toradex-ti-6.6.y"
SRCREV_TI = "fe29b3e08bf4dfd2cc2b0330307e8d25d6ec7994"

SRCBRANCH:verdin-am62 = "${SRCBRANCH_TI}"
SRCBRANCH:verdin-am62p = "${SRCBRANCH_TI}"
SRCREV:verdin-am62 = "${SRCREV_TI}"
SRCREV:verdin-am62p = "${SRCREV_TI}"

TEZI_EXTERNAL_KERNEL_DEVICETREE = "${OPTOLOGIC_DEVICETREE_OVERLAYS}"

# The overlays.txt file will be overwritten by device-tree-overlays-ti
# Remove it to avoid packaging conflicts
TEZI_EXTERNAL_KERNEL_DEVICETREE_BOOT = ""
do_deploy:append() {
    rm -f ${DEPLOYDIR}/overlays.txt
}

COMPATIBLE_MACHINE = "^(verdin-am62|verdin-am62p)$"
