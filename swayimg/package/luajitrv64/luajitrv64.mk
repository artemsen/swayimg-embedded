################################################################################
#
# luajit
#
################################################################################

LUAJITRV64_VERSION = e9c0b90b64df769a53fda125c4fff31557091762
LUAJITRV64_SITE = $(call github,plctlab,LuaJIT,$(LUAJITRV64_VERSION))
LUAJITRV64_LICENSE = MIT
LUAJITRV64_LICENSE_FILES = COPYRIGHT
LUAJITRV64_CPE_ID_VENDOR = luajit
LUAJITRV64_CPE_ID_VERSION = 2.1.0
LUAJITRV64_CPE_ID_UPDATE = beta3

# Fixed in 53f82e6e2e858a0a62fd1a2ff47e9866693382e6
LUAJITRV64_IGNORE_CVES += CVE-2020-15890

# Fixed in e296f56b825c688c3530a981dc6b495d972f3d01
LUAJITRV64_IGNORE_CVES += CVE-2020-24372

# Fixed in 343ce0edaf3906a62022936175b2f5410024cbfc
LUAJITRV64_IGNORE_CVES += CVE-2024-25176

# Fixed in 85b4fed0b0353dd78c8c875c2f562d522a2b310f
LUAJITRV64_IGNORE_CVES += CVE-2024-25177

# Fixed in defe61a56751a0db5f00ff3ab7b8f45436ba74c8
LUAJITRV64_IGNORE_CVES += CVE-2024-25178

LUAJITRV64_INSTALL_STAGING = YES

LUAJITRV64_PROVIDES = luainterpreter

ifeq ($(BR2_PACKAGE_LUAJITRV64_COMPAT52),y)
LUAJITRV64_XCFLAGS += -DLUAJITRV64_ENABLE_LUA52COMPAT
endif

# The luajit build procedure requires the host compiler to have the
# same bitness as the target compiler. Therefore, on a x86 build
# machine, we can't build luajit for x86_64, which is checked in
# Config.in. When the target is a 32 bits target, we pass -m32 to
# ensure that even on 64 bits build machines, a compiler of the same
# bitness is used. Of course, this assumes that the 32 bits multilib
# libraries are installed.
ifeq ($(BR2_ARCH_IS_64),y)
LUAJITRV64_HOST_CC = $(HOSTCC)
# There is no LUAJITRV64_ENABLE_GC64 option.
else
LUAJITRV64_HOST_CC = $(HOSTCC) -m32
LUAJITRV64_XCFLAGS += -DLUAJITRV64_DISABLE_GC64
endif

# We unfortunately can't use TARGET_CONFIGURE_OPTS, because the luajit
# build system uses non conventional variable names.
define LUAJITRV64_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) PREFIX="/usr" \
		STATIC_CC="$(TARGET_CC)" \
		DYNAMIC_CC="$(TARGET_CC) -fPIC" \
		TARGET_LD="$(TARGET_CC)" \
		TARGET_AR="$(TARGET_AR) rcus" \
		TARGET_STRIP=true \
		TARGET_CFLAGS="$(TARGET_CFLAGS)" \
		TARGET_LDFLAGS="$(TARGET_LDFLAGS)" \
		HOST_CC="$(LUAJITRV64_HOST_CC)" \
		HOST_CFLAGS="$(HOST_CFLAGS)" \
		HOST_LDFLAGS="$(HOST_LDFLAGS)" \
		BUILDMODE=dynamic \
		XCFLAGS="$(LUAJITRV64_XCFLAGS)" \
		-C $(@D) amalg
endef

define LUAJITRV64_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) PREFIX="/usr" DESTDIR="$(STAGING_DIR)" LDCONFIG=true -C $(@D) install
endef

define LUAJITRV64_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) PREFIX="/usr" DESTDIR="$(TARGET_DIR)" LDCONFIG=true -C $(@D) install
endef

define LUAJITRV64_INSTALL_SYMLINK
	ln -fs luajit $(TARGET_DIR)/usr/bin/lua
endef
LUAJITRV64_POST_INSTALL_TARGET_HOOKS += LUAJITRV64_INSTALL_SYMLINK

# host-efl package needs host-luajit to be linked dynamically.
define HOST_LUAJITRV64_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) PREFIX="$(HOST_DIR)" BUILDMODE=dynamic \
		TARGET_LDFLAGS="$(HOST_LDFLAGS)" \
		XCFLAGS="$(LUAJITRV64_XCFLAGS)" \
		-C $(@D) amalg
endef

define HOST_LUAJITRV64_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) PREFIX="$(HOST_DIR)" LDCONFIG=true -C $(@D) install
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
