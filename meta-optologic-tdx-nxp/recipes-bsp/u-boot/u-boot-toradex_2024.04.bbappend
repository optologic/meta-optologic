FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:colibri-imx8x = " file://0001-colibri-imx8x-change-default-carrier-board-to-iris-v.patch"
