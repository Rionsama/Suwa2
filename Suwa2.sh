#!/bin/bash
apt update
apt upgrade -y
wget https://github.com/Suwayomi/Suwayomi-Server/releases/download/v1.1.1/Suwayomi-Server-v1.1.1-r1535-debian-all.deb
dpkg -i Suwayomi-Server-v1.1.1-r1535-debian-all.deb
apt --fix-broken install -y
cat > /etc/systemd/system/suwayomi-server.service << EOF
[Unit]
Description=Suwayomi Server
After=network.target

[Service]
Type=simple
User=root
ExecStart=/usr/bin/suwayomi-server
WorkingDirectory=/usr/bin
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable suwayomi-server
systemctl start suwayomi-server
reboot
