#!/bin/bash
# Edit dnf for Fedora
# Tested on: 35 = worked
# Run as root.......

echo "Enableing Fastest Mirrors"
echo
echo "fastestmirror=True" >> /etc/dnf/dnf.conf
echo "deltarpm=True" >> /etc/dnf/dnf.conf
echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf
echo
echo "All Done"
echo
echo "Hit Enter to continue"
read c
