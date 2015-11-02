#!/bin/bash

alias install='sudo apt-get install'
alias update='sudo apt-get update && sudo apt-get upgrade'
alias upgrade='sudo apt-get dist-upgrade'
alias uninstall='sudo apt-get purge'
alias remove='sudo apt-get autoremove'
alias ifrelease='sudo dhclient -r -v'
alias ifrenew='sudo dhclient -v'

function ics_enable()
{
    local from_if="${1}"
    local to_if="${2}"
    sudo sysctl -w net.ipv4.ip_forward=1

    sudo iptables -F
    sudo iptables -t nat -F
    sudo iptables -t mangle -F
    sudo iptables --table nat --append POSTROUTING --out-interface "${from_if}" -j MASQUERADE
    sudo iptables --append FORWARD --in-interface "${to_if}" -j ACCEPT
    sudo dnsmasq --interface="${to_if}" --no-dhcp-interface="${to_if}"
}

function ics_disable()
{
    local from_if="${1}"
    local to_if="${2}"
    sudo sysctl -w net.ipv4.ip_forward=0

    sudo iptables --table nat --delete POSTROUTING --out-interface "${from_if}" -j MASQUERADE
    sudo iptables --delete FORWARD --in-interface "${to_if}" -j ACCEPT
    sudo dnsmasq --except-interface="${to_if}" --no-dhcp-interface="${to_if}"
}
