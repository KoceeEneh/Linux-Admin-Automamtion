#!/bin/bash

#function that checks if command was successful
check_command() {
    if [ $? -eq 0 ]; then
        echo "Command executed successfully."
    else
        echo "Command failed."
    fi
}


#function to create user
create_user() {
    read -p "Enter username: "username
    sudo adduser "$username"
    check_command "creating user $username"
    echo "User $username created successfully."

}


#function to modify user
modify_user() {
    read -p "Enter username: " username
    read -p "Enter new shell (e.g)"
    sudo usermod -s "$shell" "$username"
    check_command "Modifying user $username"
    echo "User $username successfully modified!"

}


#function to delete user
delete_user() {
    read -p "Enter username: " username
    sudo userdel -r "$username"
    check_command "Deleting user $username"
    echo "User $username successfully deleted!"

}


#function to set up SSH key
setup_ssh () {
    read -p "Enter username: "username
    sudo mkdir -p  "/home/$username/.ssh"
    check_command "Creating .ssh directory for user $username"
    sudo touch "/home/$username/.ssh/authorized_keys"
    sudo chown -R "$username:$username" "/home/$username/.ssh"
    sudo chmod 700 "/home/$username/.ssh/authorized_keys"
    sudo chmod 600 "/home/$username/.ssh/authorized_keys"
    check_command "Setting permissions for $username's SSH keys"
    echo "SSH key setup complete for $username."
    
}


#function for password policy
enforce_password_policy() {
    sudo apt install libpam-pwquality -y
    check_command "installing password policy package"
    echo "password requisite pam_pwquality.so retry=3 minlen=10 ucredit=-1 dcredit=-1 ocredit=-1 lcredit=-1 difok=4" | sudo tee -a /etc/pam.d/common-password
    check_command "setting password policy"
    echo "Password policy successfully enforced."

}


#function to manage user groups
manage_groups() {
    read -p "Enter group name: " groupname
    read -p "Enter username: " username
    sudo groupadd "$groupname" "$username"
    sudo ussermod -aG "$groupname" "$username"
    check_command "adding $username to group $groupname"
    echo "user $username successfully added to group $groupname."

}


#Menu options
echo "Select an option:"
echo "1. Create User"
echo "2. Modify User"
echo "3. Delete User"
echo "4. Setup SSH Keys"
echo "5. Enforce Password Policy"
echo "6. Manage User Groups"
echo "7. Exit"
read -p "Enter choice: " choice

case $choice in
    1) create_user ;;
    2) modify_user ;;
    3) delete_user ;;
    4) setup_ssh ;;
    5) enforce_password_policy ;;
    6) manage_groups ;;
    7) exit 0 ;;
    *) echo "Invalid choice. Please try again."

esac
