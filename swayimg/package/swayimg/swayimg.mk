################################################################################
#
# swayimg
#
################################################################################

SWAYIMG_VERSION = 3c43ce3a58c85c1da45907ef555664737ccc2f81
SWAYIMG_SITE = $(call github,artemsen,swayimg,$(SWAYIMG_VERSION))
SWAYIMG_LICENSE = MIT
SWAYIMG_LICENSE_FILES = LICENSE

SWAYIMG_DEPENDENCIES = \
	fontconfig \
	freetype \
	libxkbcommon \
	luajitrv64

SWAYIMG_CONF_OPTS = \
	-Dbash=disabled \
	-Dzsh=disabled \
	-Dlicense=false \
	-Ddoc=false \
	-Dluameta=false \
	-Dman=false \
	-Ddesktop=false \
	-Dstrip=true

$(eval $(meson-package))
