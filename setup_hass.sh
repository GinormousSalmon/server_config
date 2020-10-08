#!/bin/bash

# curl "https://raw.githubusercontent.com/GinormousSalmon/server_config/main/setup_hass.sh" | bash -s

sudo apt update -y
sudo apt upgrade -y
sudo apt install python3-dev python3-pip python3-venv libffi-dev libssl-dev -y

# sudo adduser --system homeassistant && addgroup homeassistant
# sudo adduser homeassistant dialout
sudo mkdir /opt/homeassistant
# sudo mkdir /opt/homeassistant/config
# sudo chown homeassistant:homeassistant /opt/homeassistant

# sudo su -s /bin/bash homeassistant
cd /opt/homeassistant
# python3 -m venv /opt/homeassistant
# source bin/activate

python3 -m pip install wheel
pip3 install homeassistant

# sudo su -s /bin/bash root
sudo rm /etc/systemd/system/hass.service

echo "[Unit]" >> /etc/systemd/system/hass.service
echo "Description=Home Assistant" >> /etc/systemd/system/hass.service
echo "After=multi-user.target" >> /etc/systemd/system/hass.service
echo "Conflicts=getty@tty1.service" >> /etc/systemd/system/hass.service
echo "" >> /etc/systemd/system/hass.service

echo "[Service]" >> /etc/systemd/system/hass.service
echo "Type=simple" >> /etc/systemd/system/hass.service
echo "ExecStart=hass --log-file /opt/homeassistant/hass.log" >> /etc/systemd/system/hass.service
echo "" >> /etc/systemd/system/hass.service

echo "[Install]" >> /etc/systemd/system/hass.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/hass.service

systemctl --system daemon-reload
systemctl enable hass
systemctl start hass
