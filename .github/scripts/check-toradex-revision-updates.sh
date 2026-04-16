#!/bin/bash
#
# Copyright (C) 2026 OPTO Logic
# SPDX-License-Identifier: MIT

set -euo pipefail

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

latest_stable_tag=$(git ls-remote --tags https://git.toradex.com/toradex-manifest.git | awk -F/ '{print $NF}' | sort -V | tail -n 1) || {
    echo -e "Failed to fetch the latest stable tag from the Toradex manifest repository.\n"
    exit 1
}

current_tag=$(grep -oP 'TORADEX_TAG:\s*\K.*' $SCRIPT_DIR/../workflows/yocto-toradex-optologic-ci.yml) || {
    echo -e "Failed to extract the current Toradex tag from the workflow file.\n"
    exit 1
}

if [ "$latest_stable_tag" != "$current_tag" ]; then
    echo -e "A new Toradex manifest revision is available: $latest_stable_tag (current: $current_tag). Updating the workflows\n"

    sed -i "s/TORADEX_TAG:\s*$current_tag/TORADEX_TAG: $latest_stable_tag/g" $SCRIPT_DIR/../workflows/yocto-toradex-optologic-ci.yml || {
        echo -e "Failed to update the yocto-toradex-optologic-ci.yml workflow file with the new Toradex tag.\n"
        exit 1
    }

    sed -i "s/TORADEX_TAG:\s*$current_tag/TORADEX_TAG: $latest_stable_tag/g" $SCRIPT_DIR/../workflows/torizon-optologic-binary.yml || {
        echo -e "Failed to update the torizon-optologic-binary.yml workflow file with the new Toradex tag.\n"
        exit 1
    }

    latest_stable_tag_commit=$(git ls-remote --tags https://git.toradex.com/toradex-manifest.git | grep "refs/tags/$latest_stable_tag$" | awk '{print $1}') || {
        echo -e "Failed to fetch the commit hash for the latest stable tag from the Toradex manifest repository.\n"
        exit 1
    }
    current_tag_commit=$(git ls-remote --tags https://git.toradex.com/toradex-manifest.git | grep "refs/tags/$current_tag$" | awk '{print $1}') || {
        echo -e "Failed to fetch the commit hash for the current tag from the Toradex manifest repository.\n"
        exit 1
    }

    sed -i "s/Toradex Yocto BSP \s*$current_tag/Toradex Yocto BSP $latest_stable_tag/g" $SCRIPT_DIR/../../README-tdx.md &&
    sed -i "s/tag:\s*$current_tag/tag: $latest_stable_tag/g" $SCRIPT_DIR/../../README-tdx.md &&
    sed -i "s/commit:\s*$current_tag_commit/commit: $latest_stable_tag_commit/g" $SCRIPT_DIR/../../README-tdx.md || {
        echo -e "Failed to update the README-tdx.md file with the new Toradex tag.\n"
        exit 1
    }

    echo "latest_stable_tag=$latest_stable_tag" >> $GITHUB_OUTPUT
    exit 2
else
    echo -e "The current Toradex revision is up to date: $current_tag\n"
    exit 0
fi
