# Docker-Sing-Box
*** TÂM ĐẮC NHẤT TỚI GIỜ [>3<]
## CẤU HÌNH MÚI GIỜ
```
timedatectl set-timezone Asia/Ho_Chi_Minh
```
## CÀI Docker:
```
bash <(curl -sSL https://get.docker.com)
```
## config.json
```
{
  "inbounds": [
    {
      "type": "vless",
      "listen": "0.0.0.0",
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
      "listen": "0.0.0.0",
      "listen_port": 16557,
      "users": [
        {
          "Username": "thoitiet",
          "Password": "thoitiet"
        }
      ]
    }
  ],
  "outbounds": [
    {
      "tag": "direct",
      "type": "direct"
    },
    {
      "type": "block",
      "tag": "block"
    }
  ],
  "route": {
    "rules": [
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
## KHỞI ĐỘNG 
```
docker run -itd \
  -v ./config.json:/etc/sing-box/config.json \
  --network=host \
  --dns 8.8.8.8 \
  --dns 8.8.4.4 \
  --env TZ=Asia/Ho_Chi_Minh \
  --name=sing-box \
  --restart=unless-stopped \
  ghcr.io/sagernet/sing-box \
  -D /var/lib/sing-box \
  -C /etc/sing-box/ run
```
## Check logs
```
docker logs -f sing-box
```
## Làm mới
```
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
```
## Hạt nhân tuỳ chỉnh tcp xoá kernel
```
bash -c "$(curl -L https://raw.githubusercontent.com/ylx2016/Linux-NetSpeed/master/tcp.sh)"
```
## Hạt nhân tuỳ chỉnh tcp không xoá kernel
```
bash -c "$(curl -L https://raw.githubusercontent.com/ylx2016/Linux-NetSpeed/master/tcpx.sh)"
```
## Xử lý vấn đề không thể truy cập lưu lượng truy cập trực tiếp của DAE trong một số môi trường mạng nhất định
```
sudo iptables -P FORWARD DROP
sudo iptables -A FORWARD -p tcp --dport 443 -j ACCEPT
sudo iptables -A FORWARD -p udp --dport 443 -j ACCEPT
sudo iptables -A FORWARD -p tcp --dport 80 -j ACCEPT
sudo iptables -A FORWARD -p udp --dport 80 -j ACCEPT
```
## HOẶC
```
sudo iptables -P FORWARD ACCEPT
```
## HOÀN NGUYÊN 
```
sudo iptables -P FORWARD DROP
```
## XOÁ frontend
```
sudo kill -9 3188
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/lib/dpkg/lock
sudo dpkg --configure -a
```
## XỬ LÝ TRÀN BỘ NHỚ
```
bash -c "$(curl -L https://raw.githubusercontent.com/Thaomtam/Docker-Sing-Box/main/restart_singbox.sh)"
```
## Ký ssl
```
bash -c "$(curl -L https://raw.githubusercontent.com/Thaomtam/Docker-Sing-Box/main/ssl.sh)" @domain.com
```
