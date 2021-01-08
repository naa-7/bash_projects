#!/bin/bash

#Directory of download
echo "Directory list:"
cd && ls
echo -n "Enter name of DIRECTORY of download: "
read DIRECTORY
cd && cd $DIRECTORY
echo "Directory of download: $PWD"

#Pasting url link or creating file which contains links
echo -n "Do you want to enter URL LINK or FILE containing url links? (U/F): " 
read CHOICE1
if [ $CHOICE1 == 'U' ] || [ $CHOICE1 == 'u' ] 
then
 	echo -n "Enter Youtube url to begin download: "
 	read PLAYLIST
elif [ $CHOICE1 == 'F' ] || [ $CHOICE1 == 'f' ] 
then
 	echo -n "Enter name of FILE containing url links: "
 	read FILE
	FILENAME=$FILE.txt
	echo -e "1) Paste url links under this line\n2) Click ctrl+s then ctrl+x to exit" > $FILENAME
	nano $FILENAME
	# sed with -i parameter deletes a specific line, in this case lines 1 and 2
	sed -i '1,2d' $FILENAME

else
 	echo "Error, Program Exit"
 	exit 1
fi

#Creating folder if needed & copying urls file to folder 
echo -n "Do you want to create FOLDER containing your downloads? (Y/N): "
read CHOICE2
if [ $CHOICE2 == 'Y' ] || [ $CHOICE2 == 'y' ]	
#if [ $CHOICE2 = 'Y' -o $CHOICE2 = 'y' ] -o refers to "OR"
#you can use either '=' or '==' to refer to "equal to" but in Bash '=' is the standard
then 
 	echo -n "Enter name of folder: "
 	read FOLDER
 	mkdir $FOLDER && cd $FOLDER
 	if [ $CHOICE1 == 'F' ] || [ $CHOICE1 == 'f' ]
 	then
		mv ../$FILENAME $PWD
	fi
fi

#Choosing download output type
echo -n "Do you want VIDEO or AUDIO download? (V/A): "
read CHOICE3
if [ $CHOICE1 == 'F' ] || [ $CHOICE1 == 'f' ]
then
 	if [ $CHOICE3 == 'A' ] || [ $CHOICE3 == 'a' ]
 	then
  		youtube-dl -x --audio-format mp3 -a $FILENAME
		rm -rf $FILENAME 	
	elif [ $CHOICE3 == 'V' ] || [ $CHOICE3 == 'v' ]
 	then
  		youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' -a $FILENAME
		rm -rf $FILENAME
	else
		echo "Error, Program Exit"
		exit
 	fi
elif [ $CHOICE3 = 'A' ] || [ $CHOICE3 = 'a' ]
then
 	youtube-dl -x --audio-format mp3 $PLAYLIST
elif [ $CHOICE3 == 'V' ] || [ $CHOICE3 == 'v' ]
then
 	youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' $PLAYLIST
else
 	echo "Error, Program Exit"
 	exit 1
fi

echo ""
echo "#############################"
echo "###  DOWNLOAD SUCCESSFUL  ###"
echo "#############################"
