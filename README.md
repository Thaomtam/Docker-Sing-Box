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
      "users": [
        {
          "uuid": "thời-tiết"
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
          "Username": "thời-tiết",
          "Password": "thời-tiết"
        }
      ]
    }
  ],
  "outbounds": [
        {
            "type": "direct"
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
  -p 8080:8080 \
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
