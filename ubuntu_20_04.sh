#!/bin/bash

# Install dependencies
sudo apt update
sudo apt install curl

# Install the OpenVPN repository key used by the OpenVPN packages
curl -O https://swupdate.openvpn.net/repos/openvpn-repo-pkg-key.pub
sudo apt-key add openvpn-repo-pkg-key.pub && rm -f openvpn-repo-pkg-key.pub

# Add the OpenVPN repository
DISTRO=$(lsb_release -c | awk '{print $2}')
sudo curl https://swupdate.openvpn.net/community/openvpn3/repos/openvpn3-$DISTRO.list -o /etc/apt/sources.list.d/openvpn3.list
sudo apt update

# Install OpenVPN Connector setup tool
sudo apt install python3-openvpn-connector-setup

# Enable IP forwarding
sudo sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
sudo sed -i 's/#net.ipv6.conf.all.forwarding=1/net.ipv6.conf.all.forwarding=1/g' /etc/sysctl.conf
sudo sysctl -p

# Run openvpn-connector-setup to install ovpn profile and connect to VPN.
# You will be asked to enter setup token. You can get setup token from Linux
# Connector configuration page in OpenVPN Cloud Portal
sudo openvpn-connector-setup
