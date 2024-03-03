#!/bin/bash

while true
    do

        time_current=$( echo '{ "command": ["get_property", "time-pos"] }' | socat - /tmp/mpvsocket | tr ":" "\n" | tr "," "\n" | head -n 2 | tail -n 1 | tr "." "\n" | tail -n 2 | head -n 1 )
        time_remaining=$( echo '{ "command": ["get_property", "time-remaining"] }' | socat - /tmp/mpvsocket | tr ":" "\n" | tr "," "\n" | head -n 2 | tail -n 1 | tr "." "\n" | tail -n 2 | head -n 1 )
        filename=$( echo '{ "command": ["get_property", "filename"] }' | socat - /tmp/mpvsocket | tr ":" "\n" | tr "," "\n" | head -n 2 | tail -n 1 | tr -d '"' )

        echo $time_current
        echo $time_remaining

        if [ -n "$time_remaining" ] || [ -n "$time_current" ]; then
            time_total=$(( $time_current + $time_remaining ))

            time_current=$( date -d@$time_current -u +%H:%M:%S )
            time_total=$( date -d@$time_total -u +%H:%M:%S )

            echo $time_current / $time_total > /tmp/obs_mpv_timestamp
            echo "here"
        else
            echo "00:00:00 / 00:00:00" > /tmp/obs_mpv_timestamp
            echo "gere"
        fi

        if [ -z "$filename" ] || [ "$filename" == "0" ]; then
            filename="waiting for video file"
        fi

	    length=${#filename}
	    spaces_needed=$(( 128 - length ))
	    for ((i = 0; i < spaces_needed; i++)); do
		    filename+=" "
	    done
	    echo "$filename" > /tmp/obs_mpv_filename

        sleep 1

    done
