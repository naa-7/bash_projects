#!/bin/bash

count=$(grep "processor*" /proc/cpuinfo | wc --lines)
counter=120
for second in {1..120}
do
echo -ne "Waiting time: $counter\033[K\r"
counter=$((counter-1))
while [ $count != 0 ]
do
  yes > /dev/null &
  count=$((count-1))
done
sleep 1s
done

if [ $count == 0 ]
then
  echo "Enter password to stop process"
  sudo killall yes
  sleep 1.5s
  echo -ne "\033[A\033[2K\033[A\033[K\r"
fi
