#!/bin/bash

sudo -i

apt update -y
apt upgrade -y
apt install python3-dev python3-pip python3-venv libffi-dev libssl-dev -y

adduser --system homeassistant && addgroup homeassistant
adduser homeassistant dialout
mkdir /opt/homeassistant
mkdir /opt/homeassistant/config
chown homeassistant:homeassistant /opt/homeassistant

cd /opt/homeassistant
python3 -m venv /opt/homeassistant
source bin/activate

python3 -m pip install wheel
pip3 install homeassistant

rm /etc/systemd/system/hass.service

echo "[Unit]" >> /etc/systemd/system/hass.service
echo "Description=Home Assistant" >> /etc/systemd/system/hass.service
echo "After=network.target" >> /etc/systemd/system/hass.service
echo "" >> /etc/systemd/system/hass.service

echo "[Service]" >> /etc/systemd/system/hass.service
echo "Type=simple" >> /etc/systemd/system/hass.service
echo "User=homeassistant" >> /etc/systemd/system/hass.service
echo "ExecStart=/opt/homeassistant/bin/hass -c /opt/homeassistant/config --log-file /opt/homeassistant/hass.log" >> /etc/systemd/system/hass.service
echo "" >> /etc/systemd/system/hass.service

echo "[Install]" >> /etc/systemd/system/hass.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/hass.service

systemctl --system daemon-reload
systemctl enable hass
systemctl start hass
systemctl status hass
