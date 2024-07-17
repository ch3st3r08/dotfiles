#!/bin/bash
#echo "<img>/usr/share/pixmaps/xfce4_xicon.png</img><click>xfce4-about</click>"
#numberUpdates=$(checkupdates)
updateInfo=$(checkupdates)
numberUpdates=$(echo "$updateInfo" | wc -l)
formatStr="<txt><span weight='Bold' size='large' fgcolor='Lightgreen'><i>󰚰 </i></span>"
if [ -n "$updateInfo" ]
then
 #some calculations
 clickActionStr="<txtclick>alacritty -e bash -c 'paru && read -p \" Continue... \"' </txtclick>"
 tooltipStr=$(echo "$updateInfo" | awk '{print $1, $4}')
 formatStr=$formatStr$numberUpdates"</txt>"
 formatStr=$formatStr$clickActionStr
 formatStr=$formatStr"<tool>$tooltipStr</tool>"
 echo "$formatStr"
else
  echo ""
fi
