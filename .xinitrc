#!/bin/bash

# disable bell
xset -b

# enable numlock
#setleds -D +num

# Merge custom X resources
# xrdb -merge ${HOME}/.Xresources

dbus-update-activation-environment --systemd DISPLAY


##### dwm #####

WEATHER_URL="http://www.accuweather.com/en/de/berlin/10178/weather-forecast/178087"
MAILS=0
WEATHER=

while true
do
    sleep 5s
    fetchmail --check 2>/dev/null | sed 's/(//' | awk '{print $1-$3}' > ~/.mails
    sleep 50s
done &

while true
do
    sleep 5s
    wget -q -O- "$WEATHER_URL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $12" °C" }'| head -1 > ~/.weather
    sleep 5m
done &

while true
do
        [ -r ~/.mails   ] && MAILS="✉ $(< ~/.mails) | "   || MAILS=$MAILS
        [ -r ~/.weather ] && WEATHER="$(< ~/.weather) | " || WEATHER=$WEATHER
        VOL="🔊 $(amixer get Master | grep -oE "[[:digit:]]*%" | tr -d '%') | "
        VOL_TOGGLE=$(amixer get Master | tail -1 | sed 's/.*\[\(on\|off\)\].*/\1/')
        LOCALTIME=$(date +"%F %R")

        [[ "$VOL_TOGGLE" == "off" ]] && VOL=" 🔇 | "

        [ "$(acpi -a | grep off-line > /dev/null)" ] && ARROW="↓" || ARROW="↑"
        [ "$(acpi -b | awk '{ print $4 }' | tr -d '%,')" ] && BAT="$ARROW$(acpi -b | awk '{ print $4 }' | tr -d '%,') % | " || BAT=""

        xsetroot -name "$BAT$VOL$MAILS$WEATHER$LOCALTIME"

        sleep 5s

        # other options
        # LOCALTIME=$(date +%Z\=%Y-%m-%dT%H:%M)
        # OTHERTIME=$(TZ=Asia/Novosibirsk date +%Z\=%H:%M)
        # IP=$(for i in `ip r`; do echo $i; done | grep -A 1 src | tail -n1) # can get confused if you use vmware
        # CPUTEMP="$(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000))C"
done &

#exec dwm
