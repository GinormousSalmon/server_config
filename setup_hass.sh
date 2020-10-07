#!/bin/bash
apt update
apt upgrade
apt install python3-dev python3-pip python3-venv libffi-dev libssl-dev
python3 -m pip install wheel
pip3 install homeassistant

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
