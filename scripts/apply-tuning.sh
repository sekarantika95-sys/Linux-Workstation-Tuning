#!/bin/bash

# Linux Workstation Tuning Script
# Author: Antyka Sekar Kinasih

echo "======================================"
echo " Linux Workstation Tuning Script"
echo "======================================"

# Check root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use sudo)"
  exit 1
fi

echo "[1/4] Copying sysctl configuration..."
cp ../sysctl/99-workstation-optimizer.conf /etc/sysctl.d/

echo "[2/4] Applying sysctl settings..."
sysctl --system

echo "[3/4] Verifying key parameters..."
echo "vm.swappiness = $(cat /proc/sys/vm/swappiness)"
echo "vm.vfs_cache_pressure = $(cat /proc/sys/vm/vfs_cache_pressure)"
echo "vm.page-cluster = $(cat /proc/sys/vm/page-cluster)"

echo "[4/4] Done."

echo "Tuning applied successfully."
echo "Reboot is recommended."
