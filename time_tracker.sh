#!/bin/bash

# \r move to the beginning
# \033[1A move up 
# \033[0K erase to the end

echo "##########################"
echo "###    Time Tracker    ###"
echo "##########################"
limit=$(zenity --entry --title="Work Timer" --text="Enter tracking hours:")
echo "Timer: 00:00:00"
sleep 1 && echo -ne "\033[A\033[K\r"
h=$((limit-1))
while [ $h -ge 0 ] && [ $h -lt $limit ]
do
  for m in {0..59}
  do
    for s in {1..59}
     do
        # The -n (no newline)
        # The -e enables backlash escapes (\)
        if [ $h -le 9 ] && [ $m -le 9 ] && [ $s -le 9 ]
        then  
          echo -ne "Timer: 0$h:0$m:0$s\033[K\r"
        elif [ $h -le 9 ] &&  [ $m -le 9 ] && [ $s -gt 9 ]
        then
           echo -ne "Timer: 0$h:0$m:$s\033[K\r"
        elif [ $h -le 9 ] &&  [ $m -gt 9 ] && [ $s -le 9 ]
        then
           echo -ne "Timer: 0$h:$m:0$s\033[K\r"
	elif [ $h -le 9 ] &&  [ $m -gt 9 ] && [ $s -gt 9 ]
        then
           echo -ne "Timer: 0$h:$m:$s\033[K\r"
	elif [ $h -gt 9 ] &&  [ $m -le 9 ] && [ $s -le 9 ]
        then
           echo -ne "Timer: $h:0$m:0$s\033[K\r"
	elif [ $h -gt 9 ] &&  [ $m -le 9 ] && [ $s -gt 9 ]
        then
           echo -ne "Timer: $h:0$m:$s\033[K\r"
	elif [ $h -gt 9 ] &&  [ $m -gt 9 ] && [ $s -le 9 ]
        then
           echo -ne "Timer: $h:$m:0$s\033[K\r" 
        else
           echo -ne "Timer: $h:$m:$s\033[K\r"
        fi
     sleep 1
  done
 done 
 h=$((h+1))
done
echo "#                        #"
if [ $limit -le 9 ]
then
  echo "#      Time:0$limit:00:00     #"
else
  echo "#      Time: $limit:00:00     #"
fi
echo "#                        #"
echo "##########################"
echo "###  Program Finished  ###"
echo "##########################"
zenity --notification --text="Time Tracker Stopped"
zenity --warning --title="Time_tracker" --icon-name="notification" --ellipsize --text="Time Tracker Stopped"

