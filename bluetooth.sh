#! /bin/bash
# connect
# list
# power on off
# syntax : bash bluetooth.sh devices/connect/disconnect/settings "scan on"/"scan off"/"discoverable on"/"discoverable off"

if [ $1 == "devices" ]; then
	#echo scanning for next 5 sec...
	#timeout 5 bluetoothctl scan on
	echo "listing bluetooth devices"
	bluetoothctl devices
	echo "bash bluetooth.sh "
elif [ $1 == "connect" ]; then
	bluetoothctl power on
	mac=$(bluetoothctl devices | grep "$2" | cut -d ' '  -f 2)
	bluetoothctl connect "$mac"
elif [ $1 == "disconnect" ]; then
	mac=$(bluetoothctl devices | grep "$2" | cut -d ' '  -f 2)
        bluetoothctl disconnect "$mac"
elif [ $1 == "settings" ]; then
	if [ "$2" == "scan on" ] || [ "$2" == "scan off" ] || [ "$2" == "discoverable on" ] || [ "discoverable off" ]; then
		bluetoothctl power on
		sleep 2
		echo "analysing..."
		bluetoothctl $2
		bluetoothctl scan off
		bluetoothctl discoverable off
	else 
		bluetoothctl $2
	fi
else
	echo "no arguments were given" 
fi
