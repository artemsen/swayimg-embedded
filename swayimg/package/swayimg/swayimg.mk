################################################################################
#
# swayimg
#
################################################################################

SWAYIMG_VERSION = 898f71343b23b877d4a067770157a91dbd2d08f2
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
