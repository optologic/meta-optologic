#!/bin/bash
# CI Bitbake script for meta-optologic CI
# Builds the binary Torizon BSP image for verdin-imx8mp + 5inch display using the SSTATE cache on our self-hosted runner
# Usage: cqfd -f layers/meta-optologic/.cqfdrc -d layers/meta-optologic/.cqfd run layers/meta-optologic/.cqfd/build.sh

set -exo pipefail

# Prepare environment variables
# DL_DIR and SSTATE_DIR may be configured in the bash environment to speed up the build
export DL_DIR
export SSTATE_DIR
export BB_ENV_PASSTHROUGH_ADDITIONS="$BB_ENV_PASSTHROUGH_ADDITIONS \
    SSTATE_DIR \
    DL_DIR \
"

# Cleanup build directory (we need a clean bblayers.conf)
rm -rf build

# Initialize Torizon Build environment
MACHINE=verdin-imx8mp EULA=1 source setup-environment ./build

# Add meta-optologic layers
bitbake-layers add-layer \
    ../layers/meta-optologic/meta-optologic-tdx-common \
    ../layers/meta-optologic/meta-optologic-tdx-nxp

# Load the 5inch panel dtbo at boot time (the only one that we need the Torizon kernel patch for)
echo 'OPTOLOGIC_DEVICETREE_OVERLAYS_BOOT = "${MACHINE}_optologic_panel-cap-touch-5inch-lvds_overlay.dtbo"' >> conf/local.conf

# Run bitbake
bitbake -k torizon-docker
