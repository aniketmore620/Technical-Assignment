# System Resource Monitoring Script

## Overview
This script monitors various system resources for a proxy server and presents them in a dashboard format. It refreshes the data every few seconds, providing real-time insights. Additionally, users can view specific parts of the dashboard using command-line switches.

## Features
- **Top 10 Applications**: Displays the top 10 applications consuming the most CPU and memory.
- **Network Monitoring**: Shows the number of concurrent connections, packet drops, and network traffic in/out.
- **Disk Usage**: Displays disk space usage by mounted partitions, highlighting partitions using more than 80% of the space.
- **System Load**: Shows the current load average and CPU usage breakdown.
- **Memory Usage**: Displays total, used, and free memory, including swap memory usage.
- **Process Monitoring**: Displays the number of active processes and the top 5 processes in terms of CPU and memory usage.
- **Service Monitoring**: Monitors the status of essential services like sshd, nginx/apache, and iptables.

## Usage
You can run the script to monitor the entire system or specific sections.

### Run the script:
```bash
./monitor.sh
