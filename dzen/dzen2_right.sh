#!/bin/zsh

INTERVAL=1

# function calling intervals in seconds
DATEIVAL=1
GTIMEIVAL=60
MAILIVAL=60
CPUTEMPIVAL=1
WEATHERIVAL=1800

DATE_FORMAT='%A, %d.%m.%Y %H:%M:%S'
TIME_ZONE=Asia/Seoul
 
# Date
fdate() {
        date +$DATE_FORMAT
}

# TZ Time
fgtime() {
    print -n $(TZ=$TIME_ZONE date +'%H:%M')
}

# MPD
fmpd() {
    mpc current
}

fweather() {
   python /home/k/bin/dzen/weather.py
}

#init data
WEATHERCOUNTER=$WEATHERIVAL

while true; do
    if [ $WEATHERCOUNTER -ge $WEATHERIVAL ]; then
        PWEATHER=$(fweather)
        WEATHERCOUNTER=0
    fi


    echo "^fg(#ebac54)$(fdate)^fg()^p(+75)$PWEATHER^p(+75)$(fmpd)"


    WEATHERCOUNTER=$((WEATHERCOUNTER+1))
done
