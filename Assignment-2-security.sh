
### **Set 2: Script for Automating Security Audits and Server Hardening**

#### **Script: `security_audit.sh`**

```bash
#!/bin/bash

# Function for User and Group Audits
function audit_users_groups() {
  echo "User and Group Audits:"
  echo "All Users:"
  getent passwd
  echo "Users with UID 0:"
  awk -F: '($3 == 0) {print}' /etc/passwd
  echo "Users without passwords:"
  awk -F: '($2 == "" ) {print $1}' /etc/shadow
}

# Function for File and Directory Permissions
function audit_file_permissions() {
  echo "File and Directory Permissions:"
  echo "World-Writable Files:"
  find / -type f -perm -o+w -exec ls -l {} \;
  echo "Insecure .ssh Directories:"
  find / -type d -name ".ssh" -exec ls -ld {} \;
  echo "Files with SUID/SGID bits:"
  find / -perm /6000 -type f -exec ls -l {} \;
}

# Function for Service Audits
function audit_services() {
  echo "Service Audits:"
  echo "Running Services:"
  systemctl list-units --type=service --state=running
  echo "Critical Services Status:"
  for service in sshd iptables; do
    systemctl is-active $service &> /dev/null
    if [ $? -eq 0 ]; then
      echo "$service is running."
    else
      echo "WARNING: $service is not running."
    fi
  done
}

# Function for Firewall and Network Security
function audit_firewall_network() {
  echo "Firewall and Network Security:"
  echo "Active Firewall Rules:"
  iptables -L
  echo "Open Ports:"
  ss -tuln
  echo "IP Forwarding Configuration:"
  sysctl net.ipv4.ip_forward
}

# Function for IP and Network Configuration Checks
function audit_ip_network_config() {
  echo "IP and Network Configuration Checks:"
  echo "Public vs Private IP:"
  ip a | grep inet
  echo "Public IPs:"
  curl ifconfig.me
}

# Function for Security Updates and Patching
function audit_security_updates() {
  echo "Security Updates and Patching:"
  echo "Available Updates:"
  apt list --upgradable
}

# Function for Log Monitoring
function audit_log_monitoring() {
  echo "Log Monitoring:"
  echo "Suspicious Log Entries:"
  grep "Failed password" /var/log/auth.log
}

# Function for Server Hardening
function server_hardening() {
  echo "Server Hardening Steps:"
  echo "Implementing SSH Key-Based Authentication..."
  sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
  echo "Disabling IPv6..."
  sysctl -w net.ipv6.conf.all.disable_ipv6=1
  echo "Securing GRUB Bootloader..."
  echo "GRUB_PASSWORD=\$(echo -e 'password\npassword' | grub-mkpasswd-pbkdf2 | cut -d ' ' -f7)" >> /etc/default/grub
}

# Custom Security Checks
function custom_security_checks() {
  echo "Custom Security Checks:"
  # Custom checks can be added here
}

# Reporting and Alerting
function generate_report() {
  echo "Generating Security Audit Report..."
  audit_users_groups > report.txt
  audit_file_permissions >> report.txt
  audit_services >> report.txt
  audit_firewall_network >> report.txt
  audit_ip_network_config >> report.txt
  audit_security_updates >> report.txt
  audit_log_monitoring >> report.txt
  echo "Report generated at: $(pwd)/report.txt"
}

# Main Script Execution
audit_users_groups
audit_file_permissions
audit_services
audit_firewall_network
audit_ip_network_config
audit_security_updates
audit_log_monitoring
server_hardening
generate_report
