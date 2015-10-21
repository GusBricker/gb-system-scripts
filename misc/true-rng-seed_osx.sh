#!/bin/bash

# Designed to be ran every hour or so to seed /dev/random
# Depends on pv being installed
## brew install pv
MODEM="$1"
BLOCK_SIZE="512k"

if [[ -c ${MODEM} ]] 
then
	dd if="${MODEM}" ibs=1 count="${BLOCK_SIZE}" obs=1024 | pv -pterb -s "${BLOCK_SIZE}" | dd of=/dev/random
fi
