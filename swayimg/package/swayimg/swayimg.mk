################################################################################
#
# swayimg
#
################################################################################

SWAYIMG_VERSION = ef2babde13786a538f9a4e3b6909f4922ed44990
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
