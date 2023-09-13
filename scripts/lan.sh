#!/usr/bin/sh

while (true); do
    interface="$(iwctl device list | grep station | awk '{print$2}')"
    ssid="$(iw dev $interface link | grep SSID | cut -d ' ' -f 2-)"
    statusInet="$(iwctl station $interface show | grep State | awk '{print$2}')" 2>~/.cache/statusInet.log
    device="$(rfkill | awk '{print$3}' | grep wlan)"
    wifiStatus="$(rfkill | grep $device | awk '{print$4}')"
    interval=$(cat $(pwd)/scripts/interval.conf)
    
    if [ "$wifiStatus" = "blocked" ]; then
        echo " (off)"
    else
        echo " $ssid ($statusInet)"
    fi
    sleep $interval
done
