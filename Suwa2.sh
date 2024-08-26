#!/bin/bash

# Update package list and upgrade installed packages
apt update
apt upgrade -y

# Download the Suwayomi Server package
wget https://github.com/Suwayomi/Suwayomi-Server/releases/download/v1.1.1/Suwayomi-Server-v1.1.1-r1535-debian-all.deb

# Install the Suwayomi Server package
dpkg -i Suwayomi-Server-v1.1.1-r1535-debian-all.deb

# Fix any broken dependencies
apt --fix-broken install -y

# Create a systemd service for Suwayomi Server
cat << EOF > /etc/systemd/system/suwayomi-server.service
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

# Reload systemd to apply the new service
systemctl daemon-reload

# Enable and start the Suwayomi Server service
systemctl enable suwayomi-server
systemctl start suwayomi-server

echo "Suwayomi Server installation and setup complete."

reboot
