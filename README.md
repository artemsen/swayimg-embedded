# Swayimg slide show on embedded Linux device

This project is intended to build a minimalistic OS image for the [Mango PI MQ-Pro](https://mangopi.org/mqpro)
board (Allwinner D1 RISC-V). The board can be connected to a TV to display a slide show 24x7.

## Build

1. Get submodules:
   ```shell
   git submodule update --init
   ````
2. _(Optional)_ Set WiFi SSID and password used by the board:
   ```shell
   export WIFI_SSID="WiFi name"
   export WIFI_PSWD="WiFi password"
   ```
3. Set default config for buildroot:
   ```shell
   make -C buildroot BR2_EXTERNAL=$(pwd)/swayimg O=$(pwd)/.build mqpro_defconfig
   ```
4. Build the project:
   ```shell
   make -C buildroot BR2_EXTERNAL=$(pwd)/swayimg O=$(pwd)/.build
   ```

## Write SD card image

1. Use `dd` for writing SD card (replace `sda` with your device name):
   ```shell
   sudo dd if=sdcard.img of=/dev/sda bs=4M conv=fsync status=progress
   ```
2. _(Optional)_ Resize the second partition to max size:
   ```shell
   sudo parted -s /dev/sda "resizepart 2 -0"
   sudo resize2fs /dev/sda2
   ```
