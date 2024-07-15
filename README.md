# Docker-Sing-Box
***Vườn nhà làm quan tâm thì liên hệ t.me/ktandroidreview thanks ae
## CÀI Docker:
```
bash <(curl -sSL https://get.docker.com)
```
## KÉO
```
docker pull ghcr.io/sagernet/sing-box:v1.9.3
```
## config.json
```
{
  "log": {
    "disabled": false,
    "level": "debug",
    "timestamp": true
  },
  "inbounds": [
    {
      "type": "vless",
      "listen": "0.0.0.0",
      "listen_port": 80,
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
        "path": "/video",
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
      "type": "direct",
      "tag": "direct-out"
    },
    {
      "type": "block",
      "tag": "block"
    }
  ]
}
```
## KHỞI ĐỘNG 
```
docker run -d \
  -v ./config.json:/etc/sing-box/config.json \
  -p 80:80 \
  -p 443:443 \
  -p 16557:16557 \
  --dns 8.8.8.8 \
  --dns 8.8.4.4 \
  --name=sing-box \
  --restart=always \
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
docker stop sing-box
docker rm sing-box
```
## Hạt nhân tuỳ chỉnh tcp xoá kernel
```
bash -c "$(curl -L https://raw.githubusercontent.com/ylx2016/Linux-NetSpeed/master/tcp.sh)"
```
## Hạt nhân tuỳ chỉnh tcp không xoá kernel
```
bash -c "$(curl -L https://raw.githubusercontent.com/ylx2016/Linux-NetSpeed/master/tcpx.sh)"
```
