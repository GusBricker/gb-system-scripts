#!/bin/bash

# -- Author --
# Chris Lapa
# github.com/GusBricker/gb-system-scripts
#
# -- Usage --
# Add cronjob and to run every minute, ie:
# * * * * * DISPLAY=:0 /home/chris/splashtop_keep_alive_ubuntu.sh
# Tail launch logs at home directory of user, for example tail -f ~/splashtop-launcher.log

exec >  >(tee -a ${HOME}/splashtop-launcher.log)
exec 2> >(tee -a ${HOME}/splashtop-launcher.log>&2)
SPLASHTOP_PATH="/opt/splashtop-streamer/SRStreamer.pyc"

function splashtop_pid()
{
    echo $(pgrep -f "python.*${SPLASHTOP_PATH}")
}

con_status_output=$( nmcli networking connectivity )
st_pid=$(splashtop_pid)

if [[ "x${con_status_output}" == "xfull" ]]
then
    echo "Network up"
    if [[ "x${st_pid}" == "x" ]]
    then
        echo "Launching Splashtop"
        nohup python /opt/splashtop-streamer/SRStreamer.pyc &
    fi
else
    echo "Network down"
    if [[ "x${st_pid}" != "x" ]]
    then
        echo "Killing Splashtop: ${st_pid}"
        kill ${st_pid}
    else
        echo "Splashtop not running"
    fi
fi
