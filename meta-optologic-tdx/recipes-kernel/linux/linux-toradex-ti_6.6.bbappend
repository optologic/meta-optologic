FILESEXTRAPATHS:prepend := "${THISDIR}/linux:"

# Driver for ILI2117 touchscreen (as a module)
SRC_URI += " \
    file://touch-ili2117.cfg \
    "
