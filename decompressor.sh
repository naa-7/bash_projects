#!/bin/bash

flag=0
echo -n "input file: "
read input
directory=temp
if [ -d $directory ]
then

   cd $directory/

else

   mkdir $directory && cp $input $directory/ && cd $directory/

fi

while [[ $flag == 0 ]]
do

  inp=$(file $input)
  out="$(echo $inp | sed 's/,.*//' | sed 's/.*: //' | sed 's/\s.*//')"

  if [[ $out == "gzip" ]]
  then

     mv $input out.gz
     input="$(gzip -lv out.gz | sed -n '2p' | sed 's/.*% //')"
     gzip -d out.gz && echo "gzip: $input"

  elif [[ $out == "bzip2" ]];
  then

     mv $input out.bz2
     bzip2 -d out.bz2
     input=out
     echo "bzip2: $input"


  elif [[ $out == "POSIX" ]];
  then

     mv $input out.tar
     input=$(tar -xvf out.tar)
     echo "tar: $input" && rm out.tar


  elif [[ $out == "Zip" ]];
  then

     mv $input out.zip
     input="$(unzip out.zip | sed -n '2p' | sed 's/.*: //')"
     echo "zip: $input" && rm out.zip

  else

     flag=1

  fi

done

mv * ../ && cd ../ && rm -rf $directory
echo "Extracted file: $input"