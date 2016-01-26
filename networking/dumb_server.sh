#!/bin/bash

LISTEN_PORT="${1}"
shift

if [[ "x${LISTEN_PORT}" == "x" ]]
then
    echo "Usage: dumb_server.sh <\$1:listen port> <\$@:passed to nc>"
    exit 1
fi

if [ $# -eq 0 ]
then
    nc -l -p "${LISTEN_PORT}"
    nc_return=$?
else
    nc -l -p "${LISTEN_PORT}" -c "$@"
    nc_return=$?
fi


# Beep no matter what
echo -ne '\007'

exit ${nc_return}
