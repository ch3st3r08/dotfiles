#!/bin/sh

CHANNEL1=xfce4-panel
CHANNEL2=xfwm4

PROP1=/panels/panel-3/autohide-behavior
PROP2=/general/margin_top
PROP3=/panels/panel-3/size

auto_hide_value=$(xfconf-query -c $CHANNEL1 -p $PROP1 -lv | awk '{print $NF}')
panel_offset=5
margin_top=$(xfconf-query -c $CHANNEL2 -p $PROP2 -lv | awk '{print $NF}')
panel_height=$(xfconf-query -c $CHANNEL1 -p $PROP3 -lv | awk '{print $NF}')
panel_height_total=$((panel_height + 5))

if [ $auto_hide_value -eq 0 ]; then
    xfconf-query -c $CHANNEL2 -p $PROP2 -t int -s $((margin_top - panel_height_total))
    xfconf-query -c $CHANNEL1 -p $PROP1 -t uint -s 2
else
    xfconf-query -c $CHANNEL2 -p $PROP2 -t int -s $((margin_top + panel_height_total))
    xfconf-query -c $CHANNEL1 -p $PROP1 -t uint -s 0
fi
