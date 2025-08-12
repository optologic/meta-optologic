FILESEXTRAPATHS:prepend := "${THISDIR}/linux:"

# Driver for ILI2117 touchscreen (as a module)
SRC_URI += " \
    file://touch-ili2117.cfg \
    "

SRC_URI:append:mx8mp-nxp-bsp = " \
    file://0001-remove-mode-fixup.patch \
    "
