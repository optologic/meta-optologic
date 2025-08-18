#!/bin/bash
# CI Bitbake script for meta-optologic CI
# Builds a Yocto Toradex BSP for an image using the SSTATE cache on our self-hosted runner
# Usage: cqfd -f layers/meta-optologic/.cqfdrc -d layers/meta-optologic/.cqfd run layers/meta-optologic/.cqfd/build.sh <MACHINE>

set -exo pipefail

# Prepare environment variables
if [ -n "$1" ]; then
    MACHINE="$1"
else
    MACHINE="verdin-am62"
fi
export MACHINE
export ACCEPT_FSL_EULA="1"
# DL_DIR and SSTATE_DIR may be configured in the bash environment to speed up the build
export DL_DIR
export SSTATE_DIR
export BB_ENV_PASSTHROUGH_ADDITIONS="$BB_ENV_PASSTHROUGH_ADDITIONS \
    SSTATE_DIR \
    DL_DIR \
    MACHINE \
    ACCEPT_FSL_EULA \
"

# Cleanup build directory (we need a clean bblayers.conf)
rm -rf build

# Initialize Toradex Build environment
. ./export

# Add meta-optologic layers
bitbake-layers add-layer \
    ../layers/meta-optologic/meta-optologic-tdx-common \
    ../layers/meta-optologic/meta-optologic-tdx-nxp \
    ../layers/meta-optologic/meta-optologic-tdx-ti
# For some specific MACHINEs, we remove the NXP or TI layers to build some mixed configurations
if [ "$MACHINE" = "verdin-am62" ]; then
    bitbake-layers remove-layer \
        ../layers/meta-optologic/meta-optologic-tdx-nxp
fi
if [ "$MACHINE" = "verdin-imx8mp" ]; then
    bitbake-layers remove-layer \
        ../layers/meta-optologic/meta-optologic-tdx-ti
    sed -i '/${BBLAYERS_TI}/d' conf/bblayers.conf
fi

# Run bitbake
bitbake -k tdx-reference-minimal-image
