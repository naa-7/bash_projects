#!/bin/bash

directory=compressor_decompressor_temp_dir
gzipCounter=0
bzip2Counter=0
tarCounter=0
zipCounter=0
flag=0

# same meaning but different syntax for defining a function
#compressor() {
function compressor {
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
		read input && clear

		#if [[ $(ls -A | grep $input) ]]
		if [[ -f $input ]]
		then
			clear && break

		elif [[ $input == 'q' || $input == 'Q' ]]
		then
			echo -e "-----  Program Exit!  -----" && sleep 1		
			clear && exit 0	

		else
			echo -e "-----  Error, File Not Found!  -----" && sleep 1 && clear
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
	read counter

	if [[ $counter == "" ]]
	then 
		counter=1
	fi

	if [[ -d $directory ]]
	then
		cp $input $directory/ && cd $directory/

	else
		mkdir $directory && cp $input $directory/ && cd $directory/
	fi

	name=$input
	#for i in $(eval echo "{1..$flag}") // this for loop works the same and the latter
	for i in $(seq 1 $counter)
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
			gzipCounter=$((gzipCounter+1))

		elif [[ $type == 2 ]]
		then
			bzip2 -q $input
			input="$(ls -A | grep *.bz2)"
			mv $input $name
			bzip2Counter=$((bzip2Counter+1))

		elif [[ $type == 3 ]]
		then
			tar cf $input.tar $input
			rm $input
			input="$(ls -A | grep *.tar)"
			mv $input $name
			tarCounter=$((tarCounter+1))

		elif [[ $type == 4 ]]
		then
			zip -q $input.zip $input
			rm $input
			input="$(ls -A | grep *.zip)"
			mv $input $name
			zipCounter=$((zipCounter+1))
		fi
		input=$name

	done
}

decompressor() {
	while [[ true ]]
	do
		clear
		echo "===================================="
		echo "-----------  FILES LIST  -----------"
		echo "===================================="
		#ls -p | grep -v /
		file * | grep 'gzip\|bzip\|Zip\|POSIX' | sed 's/:.*//'
		echo "===================================="
		echo "-------   ENTER [q] TO EXIT  -------"
		echo "===================================="
		echo -n "Enter file to extract: "
		read input && clear

		if [[ -f $input ]]
		then
			clear && break

		elif [[ $input == 'q' || $input == 'Q' ]]
		then
			echo -e "---------  Program Exit!  ---------" && sleep 1		
			clear && exit 0	

		else
			echo -e "-----  Error, File Not Found!  -----" && sleep 1 && clear
		fi
	done


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
}
	
clear
echo "====================================="
echo "---------  [De]/Compressor  ---------"
echo "====================================="
echo -n "Do you want to [D]ecompress or [C]ompress a file?(D/c): "
read choice

if [[ $choice == 'D' || $choice == 'd' ]]
then
	decompressor
elif [[ $choice == 'C' || $choice == 'c' ]]
then
	compressor
fi


echo -n "Do you want to rename extracted file?(Y/n): "
read answer
if [[ $answer == 'Y' ]] || [[ $answer == 'y' ]]
then
	echo -n "Enter new name: "
	read newName
	mv $input $newName
	input=$newName
fi

mv * ../ && cd ../ && rm -rf $directory

clear
echo "==========================="
echo "Number times of extraction:"
echo "--------------------------"
echo "bzip2: $bzip2Counter"
echo "gzip:  $gzipCounter"
echo "tar:   $tarCounter"
echo "zip:   $zipCounter"
echo "==========================="
echo "Extracted file: $input"








	
