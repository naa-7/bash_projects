#!/bin/bash

# \r move to the beginning
# \033[1A move up 
# \033[0K erase to the end

echo -e "\033[37;44;1;82m##########################\033[0m"
echo -e "\033[37;44;1;82m###    Time Tracker    ###\033[0m"
echo -e "\033[37;44;1;82m##########################\033[0m"
echo -e "\033[37;44;1;82m#\033[0m                        \033[37;44;1;82m#\033[0m"

time=$(zenity --forms --title="Time Tracker" --text="Enter tracking time\n\nEx.  Hours: 1   |   Minutes: 30" \--add-entry="Hours" \--add-entry="Minutes")
limit=$(echo $time | cut -d '|' -f1)
min=$(echo $time | cut -d '|' -f2)
h=0

if [[ $limit != ?(-)+([0-9]) ]] >/dev/null 2>&1
then
  limit=0
fi

if [[ $min != ?(-)+([0-9]) ]] >/dev/null 2>&1
then
  min=0
fi

echo -e "\033[37;44;1;82m#\033[0m     \033[30;48;5;82mTime: 00:00:00\033[0m     \033[37;44;1;82m#\033[0m"
echo -e "\033[37;44;1;82m#\033[0m                        \033[37;44;1;82m#\033[0m"
echo -e "\033[37;44;1;82m##########################\033[0m"
echo -e "\033[37;44;1;82m###     Started...     ###\033[0m"
echo -e "\033[37;44;1;82m##########################\033[0m"

sleep 1 && echo -ne "\033[5A\033[K\r"

while [ $h -ge 0 ] && [ $h -le $limit ]
do
  for m in {0..59}
  do
    if [ $h -eq $limit ] && [ $m -eq $min ]
    then
      break
    fi
    for s in {0..59}
     do
        # The -n (no newline)
        # The -e enables backlash escapes (\)
        if [ $h -le 9 ] && [ $m -le 9 ] && [ $s -le 9 ]
        then  
          echo -ne "\033[37;44;1;82m#\033[0m     \033[30;48;5;82mTime: 0$h:0$m:0$s\033[0m     \033[37;44;1;82m#\033[0m\033[K\r"
        elif [ $h -le 9 ] &&  [ $m -le 9 ] && [ $s -gt 9 ]
        then
           echo -ne "\033[37;44;1;82m#\033[0m     \033[30;48;5;82mTime: 0$h:0$m:$s\033[0m     \033[37;44;1;82m#\033[0m\033[K\r"
        elif [ $h -le 9 ] &&  [ $m -gt 9 ] && [ $s -le 9 ]
        then
           echo -ne "\033[37;44;1;82m#\033[0m     \033[30;48;5;82mTime: 0$h:$m:0$s\033[0m     \033[37;44;1;82m#\033[0m\033[K\r"
	elif [ $h -le 9 ] &&  [ $m -gt 9 ] && [ $s -gt 9 ]
        then
           echo -ne "\033[37;44;1;82m#\033[0m     \033[30;48;5;82mTime: 0$h:$m:$s\033[0m     \033[37;44;1;82m#\033[0m\033[K\r"
	elif [ $h -gt 9 ] &&  [ $m -le 9 ] && [ $s -le 9 ]
        then
           echo -ne "\033[37;44;1;82m#\033[0m     \033[30;48;5;82mTime: $h:0$m:0$s\033[0m     \033[37;44;1;82m#\033[0m\033[K\r"
	elif [ $h -gt 9 ] &&  [ $m -le 9 ] && [ $s -gt 9 ]
        then
           echo -ne "\033[37;44;1;82m#\033[0m     \033[30;48;5;82mTime: $h:0$m:$s\033[0m     \033[37;44;1;82m#\033[0m\033[K\r"
	elif [ $h -gt 9 ] &&  [ $m -gt 9 ] && [ $s -le 9 ]
        then
           echo -ne "\033[37;44;1;82m#\033[0m     \033[30;48;5;82mTime: $h:$m:0$s\033[0m     \033[37;44;1;82m#\033[0m\033[K\r" 
        else
          echo -ne "\033[37;44;1;82m#\033[0m     \033[30;48;5;82mTime: $h:$m:$s\033[0m     \033[37;44;1;82m#\033[0m\033[K\r"
        fi
        sleep 1
  done
 done 
 h=$((h+1))
done

if [ $limit -le 9 ] && [ $min -le 9 ]
then
  echo -e "\033[37;44;1;82m#\033[0m     \033[37;41;5;82mTime:0$limit:0$min:00\033[0m      \033[37;44;1;82m#\033[0m"
elif [ $limit -le 9 ] && [ $min -gt 9 ]
then
  echo -e "\033[37;44;1;82m#\033[0m     \033[37;41;5;82mTime: 0$limit:$min:00\033[0m     \033[37;44;1;82m#\033[0m"
elif [ $limit -gt 9 ] && [ $min -le 9 ]
then
  echo -e "\033[37;44;1;82m#\033[0m     \033[37;41;5;82mTime: $limit:0$min:00\033[0m     \033[37;44;1;82m#\033[0m"
else
  echo -e "\033[37;44;1;82m#\033[0m     \033[37;41;5;82mTime: $limit:$min:00\033[0m     \033[37;44;1;82m#\033[0m"
fi

echo -e "\033[37;44;1;82m#\033[0m                        \033[37;44;1;82m#\033[0m"
echo -e "\033[37;44;1;82m##########################\033[0m"
echo -e "\033[37;44;1;82m###     Time is up     ###\033[0m"
echo -e "\033[37;44;1;82m##########################\033[0m"

zenity --notification --text="Time Tracker Stopped"
zenity --warning --title="Time_tracker" --icon-name="notification" --ellipsize --text="Time Tracker Stopped"


sleep 1
for i in {1..9}
do
  echo -ne "\033[A\033[2K\r"
done
