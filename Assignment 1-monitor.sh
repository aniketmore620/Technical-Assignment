#!/bin/bash

# Refresh rate in seconds
REFRESH_RATE=5

# Function to display top 10 applications consuming CPU and memory
function show_top_apps() {
  echo "Top 10 Most Used Applications (CPU & Memory):"
  ps -eo pid,comm,%mem,%cpu --sort=-%cpu | head -n 11
}

# Function to display network monitoring information
function show_network_stats() {
  echo "Network Monitoring:"
  echo "Concurrent Connections:"
  ss -tun | wc -l
  echo "Packet Drops:"
  ss -s | grep "retransmit"
  echo "Network Traffic (MB In/Out):"
  ip -s link | awk '/RX:/ {print "RX: " $2/1024/1024 " MB"} /TX:/ {print "TX: " $2/1024/1024 " MB"}'
}

# Function to display disk usage
function show_disk_usage() {
  echo "Disk Usage:"
  df -h | awk '$5 > 80 {print "WARNING: " $1 " is using " $5 " of its capacity."}'
  df -h
}

# Function to display system load and CPU usage
function show_system_load() {
  echo "System Load:"
  uptime
  echo "CPU Usage:"
  top -bn1 | grep "Cpu(s)"
}

# Function to display memory usage
function show_memory_usage() {
  echo "Memory Usage:"
  free -h
  echo "Swap Usage:"
  free -m | awk '/Swap/ {print $3 " MB used of " $2 " MB"}'
}

# Function to display process monitoring
function show_process_monitoring() {
  echo "Process Monitoring:"
  echo "Active Processes:"
  ps aux --no-heading | wc -l
  echo "Top 5 Processes (CPU & Memory):"
  ps -eo pid,comm,%mem,%cpu --sort=-%cpu | head -n 6
}

# Function to display service monitoring
function show_service_status() {
  echo "Service Monitoring:"
  for service in sshd nginx iptables; do
    systemctl is-active $service &> /dev/null
    if [ $? -eq 0 ]; then
      echo "$service is running."
    else
      echo "WARNING: $service is not running."
    fi
  done
}

# Display dashboard based on command-line switches
while true; do
  clear
  for arg in "$@"; do
    case $arg in
      -cpu)
        show_system_load
        ;;
      -memory)
        show_memory_usage
        ;;
      -network)
        show_network_stats
        ;;
      -disk)
        show_disk_usage
        ;;
      -process)
        show_process_monitoring
        ;;
      -services)
        show_service_status
        ;;
      *)
        echo "Invalid switch: $arg"
        ;;
    esac
  done
  sleep $REFRESH_RATE
done
