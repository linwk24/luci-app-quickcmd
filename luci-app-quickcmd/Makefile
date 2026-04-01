include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-quickcmd
PKG_VERSION:=1.0
PKG_RELEASE:=1
PKG_ARCH:=all
PKG_LICENSE:=MIT

PKG_BUILD_DEPENDS:=+luci-base

include $(TOPDIR)/package.mk

define Package/luci-app-quickcmd
	SECTION:=luci
	CATEGORY:=LuCI
	TITLE:=快捷命令管理
	DEPENDS:=+luci-base
	PKGARCH:=all
endef

define Package/luci-app-quickcmd/description
	在LuCI界面中预设Shell命令，点击执行时弹出确认对话框
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-app-quickcmd/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/cbi
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/quickcmd.lua $(1)/usr/lib/lua/luci/controller/
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/quickcmd.lua $(1)/usr/lib/lua/luci/model/cbi/
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/view/cbi/section_quickcmd.htm $(1)/usr/lib/lua/luci/view/cbi/
	$(INSTALL_DATA) ./files/etc/config/quickcmd $(1)/etc/config/
endef

define Package/luci-app-quickcmd/conffiles
/etc/config/quickcmd
endef

$(eval $(PKG_BUILD))