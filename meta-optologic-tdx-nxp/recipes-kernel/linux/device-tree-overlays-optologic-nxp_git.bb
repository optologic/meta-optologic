require recipes-kernel/linux/device-tree-overlays-optologic.inc

SRCBRANCH_NXP = "linux-toradex-nxp-6.6.y"
SRCREV_NXP = "89ef02fab41e06302ee8469ec65c0a92bea4f59b"

SRCBRANCH:verdin-imx8mp = "${SRCBRANCH_NXP}"
SRCREV:verdin-imx8mp = "${SRCREV_NXP}"
SRCBRANCH:verdin-imx8mm = "${SRCBRANCH_NXP}"
SRCREV:verdin-imx8mm = "${SRCREV_NXP}"

COMPATIBLE_MACHINE = "^(verdin-imx8mp|verdin-imx8mm)$"
