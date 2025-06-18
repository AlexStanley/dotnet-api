#!/bin/bash
set -e

APP_DIR="/var/www/myapi"
SERVICE_FILE="/etc/systemd/system/myapi.service"

# Установка .NET (если нет)
if ! dotnet --version &>/dev/null; then
  wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
  sudo dpkg -i packages-microsoft-prod.deb
  sudo apt-get update
  sudo apt-get install -y dotnet-runtime-8.0
fi

# Копируем файлы
sudo mkdir -p $APP_DIR
sudo cp -r * $APP_DIR

# Systemd unit
sudo cp install.service $SERVICE_FILE
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable myapi
sudo systemctl restart myapi
