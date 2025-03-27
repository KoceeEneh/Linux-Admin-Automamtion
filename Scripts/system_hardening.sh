#!/bin/bash
#function that cheks if commands were successful
check_command() {
    if [ $? -eq 0 ]; then
        echo "Command executed successfully."
    else
        echo "Command failed."
    fi
}


#function to secure SSH
secure_ssh(){
    echo "configuring ssh..."
    sudo sed -i 's/^#permitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
    sudo sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
    sudo sed -i 's/^#X11Forwarding.*/X11Forwarding no/' /etc/ssh/sshd_config
    echo "AllowUsers your-secure-user" | sudo tee -a /etc/ssh/sshd
    sudo systemctl restart ssh
    check_command "securing SSH settings"
    echo " SSH has been configured"

}


#function to disable unecessary service
disable_services() {
    echo "Disabling unecessary services..."
    sudo systemctl disable --now avahi-daemon.service 2>/dev/null
    sudo systemctl disable --now bluetooth.service 2>/dev/null
    sudo systemctl disable --now cups.service 2>/dev/null
    sudo systemctl disable --now rpcbind.service 2>/dev/null
    sudo systemctl disable --now nfs-server.service 2>/dev/null
    check_command "Disabling unecessary services"
    echo " uneceesary services have been disabled"
}


#function to update system packages
update_system() {
    echo "updating packages..."
    sudo apt update && sudo apt upgrade -y
    check_command "updating system packages"
    echo " System packages have been updated"

}


#function to apply security policies 
implement_security_policies() {
    echo "applying security policies..."
    sudo apt install ufw fail2ban auditd -y
    check_command "installing security tools"

    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    sudo ufw allow ssh
    sudo ufw enable
    check_command "configuring firewall"

    sudo systemctl enable --now fail2ban
    check_command "enabling fail2ban"

    sudo systemctl enable --now auditd
    check_command "enabling auditd"

    echo "Security policies have been applied"

}


#displaying menu
echo "Select an option to harden your device:"
echo "1. Secure SSH"
echo "2. Disable Unecessary Services"
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
    6) exit ;;
    *) echo "Invalid choice. Exiting..." && exit 1 ;;
    
esac
