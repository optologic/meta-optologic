require recipes-kernel/linux/device-tree-overlays-optologic.inc

SRCBRANCH_TI = "linux-toradex-ti-6.6.y"
SRCREV_TI = "f3d6ebe254c51858b2bf21078fe24848cb5f9f02"

SRCBRANCH:verdin-am62 = "${SRCBRANCH_TI}"
SRCREV:verdin-am62 = "${SRCREV_TI}"

COMPATIBLE_MACHINE = "^(verdin-am62)$"
