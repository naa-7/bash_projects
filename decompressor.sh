#!/bin/bash

echo "===================================="
echo "Files List:"
echo "-----------"
ls -p | grep -v /
echo "===================================="
echo -n "Do you want to extract a file?(Y/n): "
read choice
if [[ $choice == 'Y' ]] || [[ $choice == 'y' ]]
then

   flag=0
   gzipCounter=0
   bzip2Counter=0
   tarCounter=0
   zipCounter=0

   echo -n "Enter file to extract: "
   read input
   directory=temp

   if [ -d $directory ]
   then

      cp $input $directory/ && cd $directory/

   else

      mkdir $directory && cp $input $directory/ && cd $directory/

   fi

   while [[ $flag == 0 ]]
   do

     type=$(file $input)
     out="$(echo $type | sed 's/,.*//' | sed 's/.*: //' | sed 's/\s.*//')"

     if [[ $out == "gzip" ]]
     then

        mv $input out.gz
        input="$(gzip -lv out.gz | sed -n '2p' | sed 's/.*% //')"
        gzip -d out.gz
        gzipCounter=$((gzipCounter+1))

     elif [[ $out == "bzip2" ]];
     then

        mv $input out.bz2
        bzip2 -d out.bz2
        input=out
        bzip2Counter=$((bzip2Counter+1))


     elif [[ $out == "POSIX" ]];
     then

        mv $input out.tar
        input=$(tar -xvf out.tar)
        rm out.tar
        tarCounter=$((tarCounter+1))


     elif [[ $out == "Zip" ]];
     then

        mv $input out.zip
        input="$(unzip out.zip | sed -n '2p' | sed 's/.*: //')"
        rm out.zip
        zipCounter=$((zipCounter+1))

     else

        flag=1

     fi

   done

   mv * ../ && cd ../ && rm -rf $directory
   echo "==========================="
   echo "Number times of extraction:"
   echo "--------------------------"
   echo "bzip2: $bzip2Counter"
   echo "gzip:  $gzipCounter"
   echo "tar:   $tarCounter"
   echo "zip:   $zipCounter"
   echo "==========================="
   echo "Extracted file: $input"
   sleep 4 && clear

else

   exit 1

fi
