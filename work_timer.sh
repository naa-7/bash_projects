#!/bin/bash

echo "####################"
echo "###  Work Timer  ###"
echo "####################"
#echo -ne "Enter working hours: "
#read h
#sleep 1 && echo -ne "\033[A\033[2K\r"
h=$(zenity --entry --title="Work Timer" --text="Enter working hours:")
echo "Timer: $h:00:00"
sleep 1 && echo -ne "\033[A\033[K\r"
h=$((h-1))
while [ $h -le 23 ] && [ $h -ge 0 ]
do
  m=59
  while [ $m -ge 0 ]
    do
    s=59
      while [ $s -ge 0 ]
      do
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
        s=$((s-1))
     done
     m=$((m-1))
  done 
  h=$((h-1))
done 
sleep 1 && echo -ne "\033[K\r"
echo "#                  #"
echo "# Timer: 00:00:00  #"
echo "#                  #"
echo "####################"
echo "###  Time is up  ###"
echo "####################"
zenity --notification --text="Work Time Finished"
zenity --warning --title="Work Timer" --icon-name="notification" --ellipsize --text="Work Time Finished"
