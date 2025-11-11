#!/bin/sh -eu

cd "${BR2_EXTERNAL_SWAYIMG_PATH}"
exec ../buildroot/support/scripts/genimage.sh -c $2
