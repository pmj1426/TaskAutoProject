#!/bin/bash

bandwidth() { 
	network_data=$(ifstat | tail -n +4 | head -n 1 | awk '{print $6 "\t\t" $8}')
}

hard_disk_writes() {
	writes=$(iostat | tail -n +7 | head -n 1 | awk '{print $4}')
}

hard_disk_utilization() {
	remaining_disk_capacity=$(df / | tail -n 1 | awk '{print $4}')	
}

data_collection() {
	echo "Time	RX Data Rate	TX Data Rate	Disk Writes	Disk Capacity" > system_metrics.txt
	last_second=0
	ifstat -d 1
	while true
	do
		second=$SECONDS
		if [ $second -ne $last_second ] && [ $(( $SECONDS % 5 )) -eq 0 ]
		then
			bandwidth
			hard_disk_writes
			hard_disk_utilization
			echo "     $SECONDS		$network_data		$writes		$remaining_disk_capacity ">> system_metrics.txt
		fi
		last_second=$(( $second ))
	done
}
data_collection
