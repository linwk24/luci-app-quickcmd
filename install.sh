#!/bin/sh
# Quick install script for luci-app-quickcmd

INSTALL_DIR="/tmp/luci-app-quickcmd"

mkdir -p $INSTALL_DIR

echo "Installing luci-app-quickcmd..."

# Install controller
mkdir -p /usr/lib/lua/luci/controller
cp ./files/usr/lib/lua/luci/controller/quickcmd.lua /usr/lib/lua/luci/controller/

# Install CBI model
mkdir -p /usr/lib/lua/luci/model/cbi
cp ./files/usr/lib/lua/luci/model/cbi/quickcmd.lua /usr/lib/lua/luci/model/cbi/

# Install view template
mkdir -p /usr/lib/lua/luci/view/cbi
cp ./files/usr/lib/lua/luci/view/cbi/section_quickcmd.htm /usr/lib/lua/luci/view/cbi/

# Install UCI config
cp ./files/etc/config/quickcmd /etc/config/quickcmd

echo "Done! Please refresh LuCI (system ->快捷命令)"