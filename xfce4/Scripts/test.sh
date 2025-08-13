#!/bin/bash

#echo "<img>/usr/share/pixmaps/xfce4_xicon.png</img><click>xfce4-about</click>"
#numberUpdates=$(checkupdates)
while getopts "j" opts; do
  case $opts in
    j)
      jason=1
      ;;
  esac
done

updateInfo="$(checkupdates --nocolor)"
numberUpdates=$(echo "$updateInfo" | wc -l)


if [ -n "$updateInfo" ]; then
  if [[ $jason -eq 1 ]]; then
    my_packages=$(echo "$updateInfo" | awk '{ print $1,$4 }')
    echo '{"text":"'"$numberUpdates"'", "tooltip":"'${my_packages//$'\n'/\\n}'"}'
    exit
  fi
  #some calculations
  formatStr="<txt><span weight='Bold' size='large'><i>󰏔 </i></span>"
  clickActionStr="<txtclick>alacritty -e bash -c 'paru && read -p \" Continue... \"' </txtclick>"
  tooltipStr=$(echo "$updateInfo" | awk '{print $1, $4}')
  formatStr=$formatStr$numberUpdates"</txt>"
  formatStr=$formatStr$clickActionStr
  formatStr=$formatStr"<tool>$tooltipStr</tool>"
  echo "$formatStr"
else
    echo ""
fi
