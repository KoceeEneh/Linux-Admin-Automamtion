#!/bin/bash

# Function that checks if commands were successful
check_command() {
    if [ $? -eq 0 ]; then
        echo "✅ $1 succeeded."
    else
        echo "❌ $1 failed."
        exit 1
    fi
}

# Function to secure SSH
secure_ssh() {
    echo "Configuring SSH security..."

    sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
    sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
    sudo sed -i 's/^#\?X11Forwarding.*/X11Forwarding no/' /etc/ssh/sshd_config

    read -p "Enter the allowed SSH user (e.g., adminuser): " allowed_user
    echo "AllowUsers $allowed_user" | sudo tee -a /etc/ssh/sshd_config

    sudo systemctl restart ssh
    check_command "Securing SSH settings"
    echo "✅ SSH has been configured securely."
}

# Function to disable unnecessary services
disable_services() {
    echo "Disabling unnecessary services..."
    for service in avahi-daemon bluetooth cups rpcbind nfs-server; do
        sudo systemctl disable --now "$service" 2>/dev/null
    done
    check_command "Disabling unnecessary services"
    echo "✅ Unnecessary services have been disabled."
}

# Function to update system packages
update_system() {
    echo "Updating system packages..."
    sudo apt update && sudo apt upgrade -y
    check_command "Updating system packages"
    echo "✅ System packages have been updated."
}

# Function to implement security policies
implement_security_policies() {
    echo "Applying security policies..."

    sudo apt install ufw fail2ban auditd -y
    check_command "Installing security tools"

    # Configure UFW
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    sudo ufw allow ssh
    sudo ufw --force enable
    check_command "Configuring UFW firewall"

    # Enable fail2ban
    sudo systemctl enable --now fail2ban
    check_command "Enabling fail2ban"

    # Enable auditd
    sudo systemctl enable --now auditd
    check_command "Enabling auditd"

    echo "✅ Security policies have been applied."
}

# Displaying menu
echo ""
echo "========= System Hardening Menu ========="
echo "1. Secure SSH"
echo "2. Disable Unnecessary Services"
echo "3. Update System Packages"
echo "4. Implement Security Policies"
echo "5. Run All Hardening Options"
echo "6. Exit"
read -p "Enter choice: " choice

case $choice in
    1) secure_ssh ;;
    2) disable_services ;;
    3) update_system ;;
    4) implement_security_policies ;;
    5) secure_ssh && disable_services && update_system && implement_security_policies ;;
    6) echo "Exiting..." && exit 0 ;;
    *) echo "❌ Invalid choice. Exiting..." && exit 1 ;;
esac
