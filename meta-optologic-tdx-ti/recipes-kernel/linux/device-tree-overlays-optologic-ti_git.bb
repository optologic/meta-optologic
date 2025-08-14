require recipes-kernel/linux/device-tree-overlays-optologic.inc

SRCBRANCH_TI = "linux-toradex-ti-6.6.y"
SRCREV_TI = "0ae3638b985a7e3d2b4312c85fca659a0e995c05"

SRCBRANCH:verdin-am62 = "${SRCBRANCH_TI}"
SRCREV:verdin-am62 = "${SRCREV_TI}"

COMPATIBLE_MACHINE = "^(verdin-am62)$"
