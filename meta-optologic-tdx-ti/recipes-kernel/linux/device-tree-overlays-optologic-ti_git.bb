require recipes-kernel/linux/device-tree-overlays-optologic.inc

SRCBRANCH_TI = "linux-toradex-ti-6.6.y"
SRCREV_TI = "28e34dcd832cd8b048562ad6b6c29f2aba6ca214"

SRCBRANCH:verdin-am62 = "${SRCBRANCH_TI}"
SRCREV:verdin-am62 = "${SRCREV_TI}"

COMPATIBLE_MACHINE = "^(verdin-am62)$"
