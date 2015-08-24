#!/bin/bash

VPN_CONNECTION_NAME="${1}"
CHECK_TIME="15s"

while [ "true" ]
do
    con_status_output=$( nmcli con status id "${VPN_CONNECTION_NAME}" 2>&1 )
    con_status_return=$?

    if [[ ${con_status_return} -ne 0 ]]
    then
        echo "${VPN_CONNECTION_NAME}: down"
        con_up_output=$( nmcli con up id "${VPN_CONNECTION_NAME}" )
        con_up_return=$?

        if [[ ${con_up_return} -ne 0 ]]
        then
            echo "${VPN_CONNECTION_NAME}: failed to bring up, errors below..."
            echo "${con_up_output}"
        else
            echo "${VPN_CONNECTION_NAME}: up"
        fi
    else
        echo "${VPN_CONNECTION_NAME}: already up, sleeping (${CHECK_TIME})..."
        sleep ${CHECK_TIME}
    fi
done
