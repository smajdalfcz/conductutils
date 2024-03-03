#!/bin/bash

while true
    do

        playerctl metadata --format "{{ title }}" > /tmp/obs_youtube_title

        sleep 1

    done
