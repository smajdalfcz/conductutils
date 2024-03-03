#!/bin/bash

while true; do

	current_value=$(cat /tmp/obs_poll_counter)
	if [ "$current_value" == "0" ]; then
		continue
	else
		counter_parsed=$( date -d@$current_value -u +%M:%S )
		echo $counter_parsed > /tmp/obs_poll_counter_parsed
		current_value=$(( $current_value - 1 ))
		echo $current_value > /tmp/obs_poll_counter
		sleep 1
	fi

done
