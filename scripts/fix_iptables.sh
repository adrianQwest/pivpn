#!/usr/bin/env bash
# PiVPN: Fix iptables script
# called by pivpnDebug.sh

IPv4dev=$(ip route get 8.8.8.8 | awk '{for(i=1;i<=NF;i++)if($i~/dev/)print $(i+1)}')
IPv4SubNet=$(</etc/pivpn/vpnSubNet.txt)
iptables -t nat -F
iptables -t nat -A POSTROUTING -s "$IPv4SubNet.0/24" -o ${IPv4dev} -j MASQUERADE
iptables-save > /etc/iptables/rules.v4
iptables-restore < /etc/iptables/rules.v4
