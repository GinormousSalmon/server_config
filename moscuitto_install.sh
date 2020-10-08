#!/bin/bash

# curl "https://raw.githubusercontent.com/GinormousSalmon/server_config/main/moscuitto_install.sh" | bash -s

apt-add-repository ppa:mosquitto-dev/mosquitto-ppa
apt-get update
apt-get upgrade -y
apt install mosquitto -y
apt-get install mosquitto-clients -y

echo "allow_anonymous false" >> /etc/mosquitto/mosquitto.conf
echo "password_file /etc/mosquitto/mosquitto.pwd" >> /etc/mosquitto/mosquitto.conf

