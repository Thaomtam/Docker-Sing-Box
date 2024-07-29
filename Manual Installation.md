# Debian / DEB
```
bash <(curl -fsSL https://sing-box.app/deb-install.sh)
```
# Config
```
{
  "log": {
    "level": "info",
	"timestamp": true
  },
  "dns": {
    "servers": [
      {
        "tag": "Google",
        "address": "8.8.8.8",
        "strategy": "prefer_ipv4"
      }
    ]
  },
  "inbounds": [
    {
      "type": "vless",
      "listen": "::",
      "listen_port": 80,
	    "sniff": true,
      "users": [
        {
          "uuid": "thoitiet"
        }
      ],
      "multiplex": {
        "enabled": true
      },
      "transport": {
        "type": "ws",
        "path": "/gists/cache",
        "early_data_header_name": "Sec-WebSocket-Protocol",
        "headers": {
          "Host": "m.tiktok.com"
        }
      }
    },
    {
      "type": "socks",
      "listen": "::",
      "listen_port": 16557,
      "users": [
        {
          "Username": "admin123",
          "Password": "admin123123"
        }
      ]
    }
  ],
  "outbounds": [
    {
      "tag": "direct",
      "type": "direct",
	  "domain_strategy": "prefer_ipv4"
    },
	{
      "type": "dns",
      "tag": "dns-out"
    },
    {
      "type": "block",
      "tag": "block"
    }
  ],
  "route": {
    "rules": [
      {
        "protocol": "dns",
        "outbound": "dns-out"
      },
	  {
        "ip_is_private": true,
        "outbound": "block"
      },
      {
        "rule_set": [
          "geosite-google"
        ],
        "outbound": "direct"
      },
      {
        "rule_set": [
          "Geosite-vn"
        ],
        "outbound": "block"
      },
      {
        "outbound": "direct",
        "network": [
          "udp","tcp"
        ]
      }
    ],
    "rule_set": [
      {
        "tag": "Geosite-vn",
        "type": "remote",
        "format": "binary",
        "url": "https://raw.githubusercontent.com/Thaomtam/Geosite-vn/rule-set/Geosite-vn.srs",
        "download_detour": "direct"
      },
      {
        "tag": "geosite-google",
        "type": "remote",
        "format": "binary",
        "url": "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-google.srs",
        "download_detour": "direct"
      }
    ]
  },
  "experimental": {
    "cache_file": {
      "enabled": true
    }
  }
}
```
# Quản lý dịch vụ
* Đối với hệ thống Linux có systemd , thông thường quá trình cài đặt đã bao gồm dịch vụ sing-box, bạn có thể quản lý dịch vụ bằng lệnh sau:

| Operation | Command                                      |
|-----------|----------------------------------------------|
| Enable    | `systemctl enable sing-box`             |
| Disable   | `systemctl disable sing-box`            |
| Start     | `systemctl start sing-box`              |
| Stop      | `systemctl stop sing-box`               |
| Kill      | `systemctl kill sing-box`               |
| Restart   | `systemctl restart sing-box`            |
| Logs      | `journalctl -u sing-box --output cat -e`|
| New Logs  | `journalctl -u sing-box --output cat -f`|
  
