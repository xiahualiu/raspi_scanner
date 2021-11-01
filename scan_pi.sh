#!/bin/bash

# Find IP
IP=$(hostname -I | sed "s/\s//g")
echo -e "Your IP is $IP"
# Escape .
IP=$(echo -ne "$IP" | sed 's/\./\\\./g')

# Find IP with prefix length
IPP=$(ip addr | sed -n "s/.*\($IP\/[^ ]*\).*/\1/p")
echo -e "Your IP with prefix is $IPP"
echo "============================================"

# Nmap 
Result=$(sudo nmap -sP $IPP | tr '\n' ',' | sed -n 's/.*\(Nmap[^,]\+,[^,]\+,[^,]\+Raspberry[^)]*\).*/\1/p')
echo "MAC Name: $(echo -ne "$Result" | sed -n 's/.*\(Raspberry.*\)/\1/p')"
echo "      IP: $(echo -ne "$Result" | sed -n 's/.*\(\s[[:digit:]][^,]\+\).*/\1/p')"
