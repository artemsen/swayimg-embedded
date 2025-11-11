################################################################################
#
# swayimg
#
################################################################################

SWAYIMG_VERSION = 53cba37aaf30b3ccfa269a98c31dc795aae43ec4
SWAYIMG_SITE = $(call github,artemsen,swayimg,$(SWAYIMG_VERSION))
SWAYIMG_LICENSE = MIT
SWAYIMG_LICENSE_FILES = LICENSE

SWAYIMG_DEPENDENCIES = \
	fontconfig \
	freetype \
	libxkbcommon

SWAYIMG_CONF_OPTS = \
	-Dman=false -Ddesktop=false

$(eval $(meson-package))
