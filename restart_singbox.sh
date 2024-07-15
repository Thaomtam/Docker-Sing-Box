#!/bin/bash

# Tìm ID container của sing-box
CONTAINER_ID=$(docker ps -q --filter "name=sing-box")

# Kiểm tra xem container có đang chạy không
if [ -n "$CONTAINER_ID" ]; then
    echo "Restarting sing-box container..."
    docker restart $CONTAINER_ID
else
    echo "sing-box container is not running."
fi
