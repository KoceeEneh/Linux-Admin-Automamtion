#!/bin/bash

# Function to check if the last command was successful
check_command() {
    if [ $? -eq 0 ]; then
        echo "✅ SUCCESS: $1"
    else
        echo "❌ ERROR: $1"
    fi
}

# Function to create user
create_user() {
    read -p "Enter username: " username
    if id "$username" &>/dev/null; then
        echo "User $username already exists."
        return
    fi
    sudo adduser "$username"
    check_command "Creating user $username"
}

# Function to modify user
modify_user() {
    read -p "Enter username: " username
    if ! id "$username" &>/dev/null; then
        echo "User $username does not exist."
        return
    fi
    read -p "Enter new shell (e.g. /bin/bash): " shell
    sudo usermod -s "$shell" "$username"
    check_command "Modifying shell for user $username"
}

# Function to delete user
delete_user() {
    read -p "Enter username: " username
    if ! id "$username" &>/dev/null; then
        echo "User $username does not exist."
        return
    fi
    sudo userdel -r "$username"
    check_command "Deleting user $username"
}

# Function to set up SSH key
setup_ssh() {
    read -p "Enter username: " username
    if ! id "$username" &>/dev/null; then
        echo "User $username does not exist."
        return
    fi
    SSH_DIR="/home/$username/.ssh"
    sudo mkdir -p "$SSH_DIR"
    check_command "Creating .ssh directory for user $username"
    sudo touch "$SSH_DIR/authorized_keys"
    sudo chown -R "$username:$username" "$SSH_DIR"
    sudo chmod 700 "$SSH_DIR"
    sudo chmod 600 "$SSH_DIR/authorized_keys"
    check_command "Setting permissions for $username's SSH keys"
    echo "SSH key setup complete for $username."
}

# Function for password policy
enforce_password_policy() {
    sudo apt install libpam-pwquality -y
    check_command "Installing password policy package"

    LINE="password requisite pam_pwquality.so retry=3 minlen=10 ucredit=-1 dcredit=-1 ocredit=-1 lcredit=-1 difok=4"
    FILE="/etc/pam.d/common-password"
    if ! grep -qxF "$LINE" "$FILE"; then
        echo "$LINE" | sudo tee -a "$FILE"
        check_command "Setting password policy"
    else
        echo "Password policy already exists."
    fi
}

# Function to manage user groups
manage_groups() {
    read -p "Enter group name: " groupname
    read -p "Enter username: " username

    if ! getent group "$groupname" > /dev/null; then
        sudo groupadd "$groupname"
        check_command "Creating group $groupname"
    fi

    if id "$username" &>/dev/null; then
        sudo usermod -aG "$groupname" "$username"
        check_command "Adding $username to group $groupname"
    else
        echo "User $username does not exist."
    fi
}

# Main menu loop
while true; do
    echo
    echo "==========================="
    echo "   User Management Script  "
    echo "==========================="
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
        7) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
done
