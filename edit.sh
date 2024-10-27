#!/bin/bash

# Function to edit LightDM configuration
edit_lightdm() {
    LIGHTDM_CONF1="/etc/lightdm/lightdm.conf"
    LIGHTDM_CONF2="/usr/share/lightdm/lightdm.conf.d/50-myconfig.conf"

    if [ -f "$LIGHTDM_CONF1" ]; then
        echo "Editing $LIGHTDM_CONF1"
        # Add your LightDM configuration changes here
        echo "greeter-session=lightdm-gtk-greeter" >> "$LIGHTDM_CONF1"
    elif [ -f "$LIGHTDM_CONF2" ]; then
        echo "Editing $LIGHTDM_CONF2"
        # Add your LightDM configuration changes here
        echo "greeter-session=lightdm-gtk-greeter" >> "$LIGHTDM_CONF2"
    else
        echo "LightDM configuration file not found."
    fi
}

# Function to edit common-password file
edit_common_password() {
    COMMON_PASSWORD="/etc/pam.d/common-password"

    if [ -f "$COMMON_PASSWORD" ]; then
        echo "Editing $COMMON_PASSWORD"
        # Add your common-password configuration changes here
        echo "password    requisite     pam_pwquality.so retry=3" >> "$COMMON_PASSWORD"
    else
        echo "common-password file not found."
    fi
}

# Function to configure sysctl settings
configure_sysctl() {
    SYSCTL_CONF="/etc/sysctl.conf"

    if [ -f "$SYSCTL_CONF" ]; then
        echo "Configuring sysctl settings"
        # Add your sysctl configuration changes here
        echo "net.ipv4.ip_forward = 1" >> "$SYSCTL_CONF"
        echo "vm.swappiness = 10" >> "$SYSCTL_CONF"
        sysctl -p
    else
        echo "sysctl.conf file not found."
    fi
}

# Function to edit login.defs file
edit_login_defs() {
    LOGIN_DEFS="/etc/login.defs"

    if [ -f "$LOGIN_DEFS" ]; then
        echo "Editing $LOGIN_DEFS"
        # Add your login.defs configuration changes here
        sed -i '/^FAILLOG_ENAB/c\FAILLOG_ENAB YES' "$LOGIN_DEFS"
        sed -i '/^LOG_UNKFAIL_ENAB/c\LOG_UNKFAIL_ENAB YES' "$LOGIN_DEFS"
        sed -i '/^SYSLOG_SU_ENAB/c\SYSLOG_SU_ENAB YES' "$LOGIN_DEFS"
        sed -i '/^SYSLOG_SG_ENAB/c\SYSLOG_SG_ENAB YES' "$LOGIN_DEFS"
        sed -i '/^PASS_MAX_DAYS/c\PASS_MAX_DAYS 90' "$LOGIN_DEFS"
        sed -i '/^PASS_MIN_DAYS/c\PASS_MIN_DAYS 10' "$LOGIN_DEFS"
        sed -i '/^PASS_WARN_AGE/c\PASS_WARN_AGE 7' "$LOGIN_DEFS"
    else
        echo "login.defs file not found."
    fi
}

# Execute functions
edit_lightdm
edit_common_password
configure_sysctl
edit_login_defs

echo "Script execution completed."