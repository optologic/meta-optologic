#!/bin/bash
# CI Bitbake script for meta-optologic CI
# Builds the binary Torizon BSP images for verdin-imx8mp using the SSTATE cache on our self-hosted runner
# Usage: cqfd -f layers/meta-optologic/.cqfdrc -d layers/meta-optologic/.cqfd run layers/meta-optologic/.cqfd/build.sh <machine> <display>

set -exo pipefail

# Prepare environment variables
if [ -n "$1" ]; then
    MACHINE="$1"
else
    MACHINE="verdin-imx8mp"
fi

if [ -n "$2" ]; then
    DISPLAY="$2"
else
    DISPLAY="5inch-SCX0500132GGC06"
fi

export DISPLAY
# DL_DIR and SSTATE_DIR may be configured in the bash environment to speed up the build
export DL_DIR
export SSTATE_DIR
export BB_ENV_PASSTHROUGH_ADDITIONS="$BB_ENV_PASSTHROUGH_ADDITIONS \
    SSTATE_DIR \
    DL_DIR \
    DISPLAY \
"

# Cleanup build directory (we need a clean bblayers.conf)
rm -rf build

# Initialize Torizon Build environment
MACHINE=${MACHINE} EULA=1 source setup-environment ./build

# Add meta-optologic layers
bitbake-layers add-layer \
    ../layers/meta-optologic/meta-optologic-tdx-common \
    ../layers/meta-optologic/meta-optologic-tdx-nxp

# Load the panel dtbo at boot time (the only one that we need the Torizon kernel patch for)
echo 'OPTOLOGIC_DEVICETREE_OVERLAYS_BOOT = "${MACHINE}_optologic_panel-cap-touch-${DISPLAY}-lvds_overlay.dtbo"' >> conf/local.conf
echo 'DISTRO_FLAVOUR = " Toradex ${MACHINE} with OPTO Logic ${DISPLAY} Display and Touchscreen"' >> conf/local.conf

# Run bitbake
bitbake -k torizon-docker
