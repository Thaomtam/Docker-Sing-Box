#!/bin/bash

# Kiểm tra xem tên miền đã được chỉ định hay chưa
if [ -z "$1" ]; then
    echo "Bạn phải cung cấp tên miền!"
    echo "Sử dụng: $0 domain.com"
    exit 1
fi

DOMAIN=$1

# Cài đặt socat
apt update
apt install -y socat

# Cài đặt acme.sh
curl https://get.acme.sh | sh
source ~/.bashrc

# Cập nhật acme.sh
acme.sh --upgrade --auto-upgrade

# Thiết lập Let's Encrypt làm CA mặc định
acme.sh --set-default-ca --server letsencrypt

# Phát hành chứng chỉ SSL cho tên miền
acme.sh --issue -d $DOMAIN --standalone --keylength ec-256

# Cài đặt chứng chỉ
acme.sh --install-cert -d $DOMAIN --ecc \
--fullchain-file /etc/ssl/private/fullchain.cer \
--key-file /etc/ssl/private/private.key

# Thay đổi quyền truy cập
chown -R nobody:nogroup /etc/ssl/private

echo "SSL đã được ký cho $DOMAIN và cài đặt thành công."
