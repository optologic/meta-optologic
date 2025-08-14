require recipes-kernel/linux/device-tree-overlays-optologic.inc

SRCBRANCH_NXP = "linux-toradex-nxp-6.6.y"
SRCREV_NXP = "ff80ef6d5b0290e1cff521285c59155dfc077c73"

SRCBRANCH:verdin-imx8mp = "${SRCBRANCH_NXP}"
SRCREV:verdin-imx8mp = "${SRCREV_NXP}"
SRCBRANCH:verdin-imx8mm = "${SRCBRANCH_NXP}"
SRCREV:verdin-imx8mm = "${SRCREV_NXP}"

COMPATIBLE_MACHINE = "^(verdin-imx8mp|verdin-imx8mm)$"
