#!/bin/bash

# Prompt user for critical systems to not remove
read -p "Enter any critical systems to not remove (separated by spaces): " critical_systems

# Convert critical systems to an array
IFS=' ' read -r -a critical_array <<< "$critical_systems"

# List of packages to remove
packages=(
    mysql postgresql firebird mariadb mongodb
    openssh-client openssh-server ssh ftp telnet telnetd samba snmp nis
    apache nginx lighttpd jetty gunicorn mongrel tornado httpd yaws aolserver boa uwsgi hunchentoot unicorn tntnet
    aircrack-ng chkrootkit hping3 hydra john kismet nessus netcat nikto nmap ophcrack owasp snort tcpdump thc wireshark ettercap
    aircrack apache brutus cain chkrootkit crack ettercap ftp hping hydra "John the Ripper" kismet maltego metasploit nessus netcat nikto mysql nmap ophcrack "owasp zed" postgresql rainbow-crack samba snort tcpdump telnet "thc hydra" winzapper wireshark apache2 vsftpd rsync cups isc-dhcp-server6 isc-dhcp-server avahi-daemon nfs-server dovecot rpcbind slapd snmpd squid bind9 smbd nis
)

# Remove critical systems from the list of packages
for critical in "${critical_array[@]}"; do
    packages=("${packages[@]/$critical}")
done

# Purge packages
for package in "${packages[@]}"; do
    apt purge -y "$package"
done

# Disable services
for package in "${packages[@]}"; do
    systemctl disable --now "$package"
done

# Autoremove unnecessary packages
# Disable services
for package in "${packages[@]}"; do
    apt-get autoremove -y "$package"
done