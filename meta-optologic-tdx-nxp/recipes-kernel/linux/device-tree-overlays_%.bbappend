# List of Optologic overlays to be applied at boot time in addition to the
# TEZI_EXTERNAL_KERNEL_DEVICETREE_BOOT.
# We can't use the same variable because the optologic overlays are packaged
# in a different recipe.
OPTOLOGIC_DEVICETREE_OVERLAYS_BOOT ??= ""

# Replace the default incompatible overlays
TEZI_EXTERNAL_KERNEL_DEVICETREE_BOOT:remove:verdin-imx8mm = "${MACHINE_PREFIX}_dsi-to-hdmi_overlay.dtbo"
TEZI_EXTERNAL_KERNEL_DEVICETREE_BOOT:remove:verdin-imx8mp = "${MACHINE_PREFIX}_dsi-to-hdmi_overlay.dtbo"
TEZI_EXTERNAL_KERNEL_DEVICETREE_BOOT:remove:verdin-imx8mp = "${MACHINE_PREFIX}_hdmi_overlay.dtbo"
TEZI_EXTERNAL_KERNEL_DEVICETREE_BOOT:remove:colibri-imx8x = "${MACHINE_PREFIX}_vga-640x480_overlay.dtbo"

# Overwrite overlays.txt with our additional Optologic overlays to be loaded at boot time.
do_deploy:append() {
    echo "fdt_overlays=$(echo $overlays ${OPTOLOGIC_DEVICETREE_OVERLAYS_BOOT})" > ${DEPLOYDIR}/overlays.txt
}
