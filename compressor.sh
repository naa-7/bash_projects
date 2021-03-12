#!/bin/bash

directory=compressor_temp_dir
gzipCounter=0
bzip2Counter=0
tarCounter=0
zipCounter=0

while [[ true ]]
do
	clear
	echo "===================================="
	echo "-----------  FILES LIST  -----------"
	echo "===================================="
	ls -p --color | grep -v /
	#file * | grep 'gzip\|bzip\|Zip\|POSIX' | sed 's/:.*//'
	echo "===================================="
	echo "-------   ENTER [q] TO EXIT  -------"
	echo "===================================="
	echo -n "Enter name of file to compress: "
	read input

	#if [[ $(ls -A | grep $input) ]]
	if [[ -f $input ]]
	then
		clear && break

	elif [[ $input == 'q' || $input == 'Q' ]]
	then
		echo -e "\n-----  Program Exit!  -----" && sleep 1		
		clear && exit 0	

	else
		echo -e "\n-----  Error, File Not Found!  -----" && sleep 1 && clear
	fi
done

while [[ true ]]
do
	echo -e "Compression type:\n\n[1] gzip  -  [2] bzip2  -  [3] tar  - [4] zip  - [5] random\n"
	echo -n "Enter compression type number: "
	read compression_type
		
	if [[ $compression_type -le 5 ]]
	then
		break

	else
		echo -e "\n-----  Error, Wrong Entry!  -----" && sleep 1 && clear
	fi
done

echo -n "Enter times of compression: "
read flag

if [[ $flag == "" ]]
then 
	flag=1
fi

if [[ -d $directory ]]
then
	cp $input $directory/ && cd $directory/

else
	mkdir $directory && cp $input $directory/ && cd $directory/
fi

name=$input
#for i in $(eval echo "{1..$flag}") // this for loop works the same and the latter
for counter in $(seq 1 $flag)
do
	if [[ $compression_type == 5 ]]
	then
		type="$(shuf -i 1-4 -n 1)"
	else
		type=$compression_type
	fi
	
	if [[ $type == 1 ]]
	then
		gzip -q $input
		input="$(ls -A | grep *.gz)"
		mv $input $name
		input=$name
        	gzipCounter=$((gzipCounter+1))

	elif [[ $type == 2 ]]
	then
		bzip2 -q $input
		input="$(ls -A | grep *.bz2)"
		mv $input $name
		input=$name
	        bzip2Counter=$((bzip2Counter+1))

	elif [[ $type == 3 ]]
	then
		tar cf $input.tar $input
		rm $input
		input="$(ls -A | grep *.tar)"
		mv $input $name
		input=$name
	        tarCounter=$((tarCounter+1))

	elif [[ $type == 4 ]]
	then
		zip -q $input.zip $input
		rm $input
		input="$(ls -A | grep *.zip)"
		mv $input $name
		input=$name
	        zipCounter=$((zipCounter+1))
	fi

done

mv * ../ && cd ../ && rm -rf $directory

echo -n "Do you want to rename extracted file?(Y/n): "
   read answer

   if [[ $answer == 'Y' ]] || [[ $answer == 'y' ]]
   then
       echo -n "Enter new name: "
       read name
       mv $input $newName
       input=$newName
   fi

clear
echo "==========================="
echo "Number times of Compression:"
echo "--------------------------"
echo "bzip2: $bzip2Counter"
echo "gzip:  $gzipCounter"
echo "tar:   $tarCounter"
echo "zip:   $zipCounter"
echo "==========================="
echo "Compressed file name: $input"
echo "Folder of extracted file: $(find $HOME -type d -name $directory)"


















	
