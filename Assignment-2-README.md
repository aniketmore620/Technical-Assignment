# Security Audit and Server Hardening Script

## Overview
This script automates security audits and the server hardening process for Linux servers. It includes checks for common vulnerabilities, network configurations, and implements hardening measures such as disabling IPv6 and securing SSH.

## Features
- **User and Group Audits**: Lists users and groups, checks for users with UID 0, and identifies users with weak or no passwords.
- **File and Directory Permissions**: Scans for world-writable files, insecure `.ssh` directories, and files with SUID/SGID bits set.
- **Service Audits**: Lists running services, ensures critical services like `sshd` and `iptables` are running.
- **Firewall and Network Security**: Verifies firewall rules
