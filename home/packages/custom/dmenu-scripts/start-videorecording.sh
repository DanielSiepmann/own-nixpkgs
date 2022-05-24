availableDevices=$(pacmd list-sources | grep 'name:' | grep 'input' | sed 's/^.*name: <//' | sed 's/>$//')
audioDevice=$(echo -e "$availableDevices" | dmenu -i -l 5 -p "Select Audio Input")

if [ -z "$audioDevice" ]; then
    exit 1;
fi

recordingFile="/home/daniels/Videos/Recordings/output-$(date +'%F_%T').mkv" 
ffmpeg -video_size 1920x1080 -framerate 60 -f x11grab -i :0+1920x1080 -f pulse -i "$audioDevice" "$recordingFile" &
sleep 1
if [ -f "$recordingFile" ];
then
    recordingPid=$!
    echo "$recordingPid" > /tmp/runningRecording.txt
else
    notify-send -u critical "Could not start recording" "Check screen setup?"
fi
