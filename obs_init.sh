#/bin/bash

echo "0" > /tmp/obs_poll_counter &
echo "00:00" > /tmp/obs_poll_counter_parsed &
touch /tmp/obs_mpv_filename &
touch /tmp/obs_youtube_title &
echo "0" > /tmp/1.txt
echo "-----" > /tmp/2.txt
echo "0" > /tmp/3.txt
echo "-----" > /tmp/4.txt
echo "0" > /tmp/5.txt
echo "-----" > /tmp/6.txt

./obs_poll_counter.sh &
./obs_youtube_info.sh &
./obs_mpv_info.sh &
#python obs_strawpoll_result.py &

mpv --vd-lavc-dr=no --player-operation-mode=pseudo-gui --fullscreen &

obs --scene CONDUCT_MAIN
