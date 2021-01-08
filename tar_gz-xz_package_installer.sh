#!/bin/bash

# This is a program that extracts tar.gz and tar.xz packages and moves the extracted
# files to /opt directory. Then it creates a link of the application to /usr/bin
# directory. Last, it creates a desktop icon of the application.

echo "=============================================================================="
echo "============== Welcome to (tar.gz,tar.xz) Extractor & Installer =============="
echo "=============================================================================="

# Directory of download
echo "Directory list:"
echo "---------------"
cd && ls
echo "------------------------------------------------------------------------------"
echo "Note: You can either enter full name or first few letters"
echo -n "Enter name of DIRECTORY where tar file exists: "
read DIRECTory
DIRECTORY=($DIRECTory*)

if [ -d $DIRECTORY ]
then
	cd && cd $DIRECTORY
else
	echo "Directory Not Found, Program Exit!"
	echo "=============================================================================="
	exit 1
fi

# Print path to target file
echo "------------------------------------------------------------------------------"
echo "Directory of tar file: $PWD"
echo "------------------------------------------------------------------------------"

# Entering name of tar file
echo "File list:"
echo "----------" && ls *.gz && ls *.xz
echo "------------------------------------------------------------------------------"
echo "Note: You can either enter full name or first few letters"
echo -n "Enter first word of tar file: "
read name
NAME=($name*)

if [ -f $NAME ]
then
	echo "----------------------------------------------------------------------"
	echo -n "Enter extension of tar file (gz/xz): "
	read EXTENSION
else
	echo "File Not Found, Program Exit"
	echo "=============================================================================="	
	exit 1
fi

# Extracting the downloaded file to opt directory. Traditionally, the /opt directory
# is used for installing/keeping files of optional or additional Linux software
if [ $EXTENSION == "gz" ]
then
	sudo tar -xvzf $NAME -C /opt
	echo "Extracted Successfully"
	echo "------------------------------------------------------------------------------"
elif [ $EXTENSION == "xz" ]
then
	sudo tar -xvJf $NAME -C /opt
	echo "Extracted Successfully"
	echo "------------------------------------------------------------------------------"
else
	echo "Error, Program Exit!"
	echo "=============================================================================="
	exit 1
fi
# Entering name of Extracted file directory and name of application
# If there is a problem with accessing the extracted folder then remove it and extract it again
cd && echo "Directory list:"
echo "---------------"
cd /opt && ls
echo "---------------------------------------------------------------------------"
echo "Note: You can either enter full name or first few letters"
echo -n "Enter extracted file DIRECTORY name: "
read Directory
newDIRECTORY=($Directory*)

if [ -d $newDIRECTORY ]
then
	echo "File list:"
	echo "----------"
	cd $newDIRECTORY 
	if [ "$(ls -A $newDIRECTORY)" ]
	then
		ls && echo "-----------------------------------------------------------------------------"
		echo -n "Enter name of application: "
		echo "Note: You can either enter full name or first few letters"
		read Application
		APPLICATION=($Application*)
	else
		sudo rm -rf $newDIRECTORY
		cd ~/$DIRECTORY
		if [ $EXTENSION = "xz" ]
		then
			tar -xJf $NAME && cd $name*/
		else
			tar -xzf $NAME && cd $name*/
		fi
		move=$(echo "${PWD##*/}")
		cd .. && sudo mv $move /opt
		cd && echo "Directory list:"
		echo "---------------"
		cd /opt && ls
		echo "------------------------------------------------------------------------------"
		echo "Note: You can either enter full name or first few letters"
		echo -n "Enter extracted file DIRECTORY name: "
		read Directory
		newDIRECTORY=($Directory*)
		if [ -d $newDIRECTORY ]
		then
			echo "File list:"
			echo "----------"
			cd $newDIRECTORY && ls
			echo "------------------------------------------------------------------------------"
			echo "Note: You can either enter full name or first few letters"
			echo -n "Enter name of application (ex. Discord, Enter n/a if not found): "
			echo "------------------------------------------------------------------------------"

			read Application
			APPLICATION=($Application*)
		else
			echo "Error, Program Exit!"
			echo "=============================================================================="
			exit 1
		fi
	fi

else
	echo "Directory Not Found, Program Exit!"
	echo "=============================================================================="
	exit 1
fi

# Creating Discord command in bin directory
if [ -f $APPLICATION ]
then
	sudo ln -sf /opt/$newDIRECTORY/$APPLICATION /usr/bin/$APPLICATION

# Creating desktop icon and menu entry
	line=$(grep -n "Exec" *.desktop | grep -Eo '^[^:]+')
	sudo sed -i "$[line]s+.*+Exec=/usr/bin/$APPLICATION+" *.desktop
else
	echo "No Application Found!"
	echo "Note: You can either enter full name or first few letters"
	echo -n "Enter the name or first word of file with .desktop extension: "
	read Desktop
	DESKTOP=($Desktop*)
	./$DESKTOP --register-app
	echo "-----------------------------------------------------------------------------"
	echo "--------------------------Successful-----------------------------------------"
	echo "-----------------------------------------------------------------------------"
	echo "============================================================================="
	exit 0
fi

if [ -f *.png ]
then
	echo "Image list:"
	echo "-----------" && ls *.png
	echo "--------------------------------------------------------------"
	echo "Note: You can either enter full name or first few letters"
	echo -n "Enter name of application image (w/o .png) or (n/a) if not found: "
	read Image
	IMAGE=($Image*.png)
	LINE=$(grep -n "Icon" *.desktop | grep -Eo '^[^:]+')
	sudo sed -i "$[LINE]s+.*+Icon=/opt/$newDIRECTORY/$IMAGE+" *.desktop
else
	echo "No Image Found!"
fi

sudo cp -r /opt/$newDIRECTORY/*.desktop /usr/share/applications
echo "-----------------------------------------------------------------------------"
echo "---------------------------------Successful----------------------------------"
echo "-----------------------------------------------------------------------------"
echo "=============================================================================="
