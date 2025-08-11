# OpenEmbedded/Yocto BSP Layer for Optologic devices for Toradex Modules

This README file contains information on the contents of the meta-optologic-tdx-* layer.

This layer contains Yocto recipes to configure the OPTO Logic display and touchscreen drivers for Toradex SoMs (System
on Modules).

## Supported Hardware

The following displays are supported:
 - OPTO Logic 7" Display with ILI2117 touchscreen and backlight

The following SoMs platforms are supported:
 - Toradex Verdin AM62
 - Toradex Verdin i.MX8M Plus

## Supported Distributions

The OPTO Logic BSP layers are compatible with the following distributions:
 - Toradex Yocto BSP 7.3.0 (Yocto Scarthgap)

Please check-out the appropriate branch corresponding to the version of the Toradex BSP you are using.

## Dependencies

  - URI: [meta-toradex-bsp-common](https://git.toradex.com/meta-toradex-bsp-common.git)
    - branch: scarthgap-7.x.y

  - URI: [openembedded-core](https://git.openembedded.org/openembedded-core)
    - branch: scarthgap-7.x.y

Depending on your target architecture, one of:

  - URI: [meta-toradex-ti](https://git.toradex.com/meta-toradex-ti.git)
    - branch: scarthgap-7.x.y

  - URI: [meta-toradex-nxp](https://git.toradex.com/meta-toradex-nxp.git)
    - branch: scarthgap-7.x.y

These layers exact revisions are specified in the Toradex `repo` manifest:

  - URI: [toradex-manifest](https://git.toradex.com/toradex-manifest.git)
    - file: `tdxref/default.xml`
    - commit: 77cc2ee055cbe134027ca5fb3c833b700b5ee8b5
    - tag: 7.3.0
    - branch: scarthgap-7.x.y

## Structure

In order to allow selecting between TI and NXP support, while factorizing common
code, this layer is split into the following sub-layers:

- `meta-optologic-tdx-common`: Contains common recipes and configurations for Optologic displays on Toradex boards.
- `meta-optologic-tdx-ti`: Contains recipes and configurations specific to Toradex TI SoMs (e.g., Verdin AM62).
- `meta-optologic-tdx-nxp`: Contains recipes and configurations specific to Toradex NXP SoMs (e.g., Verdin i.MX8M Plus).

## Contribute

Please submit any patches and bug reports about the meta-optologic-tdx layer to the maintainer:

Maintainer: OPTO Logic Technologies S.A. <support@optologic.ch>

## Usage

### Setting up the Toradex Yocto build environment

This layer is designed to work with the Toradex Yocto BSP. You should first become familiar with the Toradex Yocto BSP
setup. Please refer to the [Toradex Yocto BSP development
documentation](https://developer.toradex.com/linux-bsp/os-development/build-yocto/yocto-project/) for instructions on
how to set up your build environment using `repo`.

### Adding the meta-optologic-tdx layer to your build

You should first download this layer within the Toradex Yocto BSP layers tree:

```bash
cd <path-to-toradex-yocto-bsp>
cd layers
git clone https://github.com/optologic/meta-optologic.git -b <yocto-version>
cd ..
```

Then, add the layer to your `bblayers.conf` file:

```bash
. export # This command must be run in the Toradex Yocto build environment
bitbake-layers add-layer layers/meta-optologic/meta-optologic-tdx-common
# Depending on your target architecture, use at least one of the following:
bitbake-layers add-layer layers/meta-optologic/meta-optologic-tdx-ti
bitbake-layers add-layer layers/meta-optologic/meta-optologic-tdx-nxp
```

The layer provides additional recipes to build device tree overlays. It allows customizes some of Toradex's recipes to
integrate our accessories.

Before building an image, you should first select your hardware architecture in the following section:

### Customizing the OPTO Logic layer configuration

Before going through this section, you should first become familiar with the [Toradex Yocto BSP custom layers
documentation](https://developer.toradex.com/linux-bsp/os-development/build-yocto/custom-meta-layers-recipes-and-images-in-yocto-project-hello-world-examples).

Our layer provides a device-tree-overlay recipe: `device-tree-overlays-optologic`. In order to load one automatically at
boot, you need to set the `OPTOLOGIC_DEVICETREE_OVERLAYS_BOOT` variable in your layer configuration file (e.g.,
`meta-customer/conf/machine/verdin-am62-extra.conf`). This file is automatically included by the Toradex Yocto BSP build
system.

You may choose among the following overlays (uncomment the one you want to use):

`${MACHINE}-extra.conf`:

```bitbake
# OPTOLOGIC_DEVICETREE_OVERLAYS_BOOT = "${MACHINE}_optologic_panel-cap-touch-5inch-lvds_overlay.dtbo"
# OPTOLOGIC_DEVICETREE_OVERLAYS_BOOT = "${MACHINE}_optologic_panel-cap-touch-7inch-lvds_overlay.dtbo"
# OPTOLOGIC_DEVICETREE_OVERLAYS_BOOT = "${MACHINE}_optologic_panel-cap-touch-10inch-lvds_overlay.dtbo"
```

The rest will be handled by our layer configuration. Feel free to take a look at the sources if you want more control
over the recipes.

### Building and flashing an image

The rest of the procedure follows the [Toradex Yocto BSP build
documentation](https://developer.toradex.com/linux-bsp/os-development/build-yocto/build-a-reference-image-with-yocto-projectopenembedded#build-the-image).
Select the image you want to build, for example:

```bash
. export
bitbake tdx-reference-multimedia-image
```

We recommend to then flash the image to your target using the Toradex Easy Installer (TEZI) tool. You can find more
information on how to use TEZI in the [Toradex Easy Installer
documentation](https://developer.toradex.com/easy-installer/toradex-easy-installer/flashing-new-image-using-tezi#install-os-images).
