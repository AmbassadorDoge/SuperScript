#!/bin/bash

# Check if the user has sudo privileges
if ! sudo -v; then
    echo "You need sudo privileges to run this script."
    exit 1
fi

echo "Installing necessary packages..."
sudo apt-get update
sudo apt-get install -y gedit git libpam-cracklib auditd mod_security clamtk clamav clamav-daemon ufw gufw iptables fail2ban

if [ $? -eq 0 ]; then
    echo "Packages installed successfully"
else
    echo "Failed to install packages"
    exit 1
fi

sudo ufw enable
sudo auditctl -e 1
sudo systemctl enable --now auditd
sudo systemctl enable --now fail2ban
sudo passwd -l root
sudo chmod 640 /etc/shadow

echo "Configuration completed successfully"
