#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
# sed -i 's/192.168.6.1/192.168.10.1/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.6.1/192.168.16.1/g' package/base-files/files/bin/config_generate
# 修改主机名称
sed -i 's/OpenWrt/Cudy-TR3000/g' package/base-files/files/bin/config_generate

# 修改WIFI名称
# sed -i 's/OpenWrt/TR3000/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# Modify default theme
# sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# 修改wifi名称
mkdir -p files/etc/uci-defaults

cat > files/etc/uci-defaults/99-custom-ssid <<'EOF'
#!/bin/sh

# 设置2.4G WiFi名称
uci set wireless.@wifi-iface[0].ssid='TR3000'

# 如果存在5G接口，设置5G名称
[ "$(uci show wireless | grep '@wifi-iface\[1\]' -c)" -gt 0 ] && \
uci set wireless.@wifi-iface[1].ssid='TR3000_5G'

# 可选：设置加密方式与密码（如你没开启加密，可注释这两行）
# uci set wireless.@wifi-iface[0].encryption='psk2'
# uci set wireless.@wifi-iface[0].key='12345678'
# [ "$(uci show wireless | grep '@wifi-iface\[1\]' -c)" -gt 0 ] && \
# uci set wireless.@wifi-iface[1].encryption='psk2'
# [ "$(uci show wireless | grep '@wifi-iface\[1\]' -c)" -gt 0 ] && \
# uci set wireless.@wifi-iface[1].key='12345678'

uci commit wireless
EOF

chmod +x files/etc/uci-defaults/99-custom-ssid
