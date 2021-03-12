#!/bin/bash

echo "###################################################"
echo "######### Github Repo Creater and Deleter #########"
echo "###################################################"
sleep 1 && echo -ne "\033[A\033[2K\r\033[A\033[2K\r\033[A\033[2K\r"
echo "--- Repo Create | Delete ---"

# checking if hub is installed and installing it if not and making the repository
if ! (dpkg -s hub >/dev/null 2>&1) && ! (rpm -q hub >/dev/null 2>&1) && ! (yum list installed hub >/dev/null 2>&1) && ! (dnf list installed hub >/dev/null 2>&1) && ! (which hub >/dev/null 2>&1) ;
then
	echo -n "hub is not found! Do you want to install it? (Y/n): "
	read answer
	echo -ne "\033[A\033[2K\r"
	if [[ $answer == 'Y' || $answer == 'y' ]] 
	then
		if (sudo apt-get -y install hub >/dev/null 2>&1) ;
		then
			echo "Finished Downloading Hub"
			sleep 1 && echo -ne "\033[A\033[2K\r\033[A\033[2K\r"
		# it works the same as the previous if condition just different format
		elif (yes | sudo pacman -S hub >/dev/null 2>&1) ;
		then
			echo "Finished Downloading Hub"
			sleep 1 && echo -ne "\033[A\033[2K\r\033[A\033[2K\r"
		# it works the same as the "if ! dpkg" condition just different format 
		elif ! (sudo yum -y install hub >/dev/null 2>&1) ;
		then
			echo "Couldn't install it, you need to install it manually"
			echo "Error, Program exit"
			sleep 2 && echo -ne "\033[A\033[2K\r\033[A\033[2K\r\033[A\033[2K\r"			
			exit 1

		fi
	else
		echo "hub is dependency for the program to work, Program Exit!"
		echo "--- Unsuccessful ---"
		sleep 2 && echo -ne "\033[A\033[2K\r\033[A\033[2K\r\033[A\033[2K\r"		
		exit 1
	fi
fi

# Creating or deleteing github repo
echo -n "Do you want to create or delete a repository? (C/d): "
read input
echo -ne "\033[A\033[2K\r"

if [[ $input == 'C' || $input = 'c' ]]
then 

	# Enter the type of repository before building 
	echo -n "Do you want to create a PUBLIC or PRIVATE repository? (P/pr): "
	read repository
	echo -ne "\033[A\033[2K\r"

	# Enter the name of the repository to name both the local folder and github repository
	echo -n "Enter the name of repository: "
	read name
	echo -ne "\033[A\033[2K\r"
	# Enter the Directory where the folder and github repository will be
	echo "==========================================================================="
	echo "Directory list:"
	echo "---------------"
	sleep 1 && echo -ne "\033[A\033[2K\r\033[A\033[2K\r" 
	cd && ls -d */
	echo "==========================================================================="
	echo -n "Enter name of DIRECTORY where repo should be (leave empty to keep in current dir): "
	read DIRECTORY
	counter=5
	while [ $counter -ge 0 ]
	do
		echo -ne "\033[A\033[2K\r"
		((counter-=1))
	done

	cd && cd $DIRECTORY
	# making the local folder
	if [ -d $name ]
	then 
		git init $name >/dev/null 2>&1 && cd $name
	elif [ ! -d $name ]
	then
		mkdir $name && git init $name >/dev/null 2>&1
		cd $name
	else
		echo "Error, Program Exit"
		echo "--- Unsuccessful ---"
		sleep 1 && echo -ne "\033[A\033[2K\r\033[A\033[2K\r"
		exit 1
	fi
	
	if [ $repository == 'P' ] || [ $repository == 'p' ]
	then
		# Checking if hub needs an access token to github account and making a file that stores the username,token, and protocol in ~/.config/ after following the mentioned steps 
		if ! (hub create 2>/dev/null) ;
		then
			echo -ne "\033[A\033[2K\r\033[A\033[2K\r"
			touch temp
			echo "---------------------------------------------------------------" >> temp
			echo "First time user, login to your github account and do the following:" >> temp
			echo "1) Under 'Settings' click on 'Developer settings'" >> temp
			echo "2) Under 'Developer settings' click on Personal access tokens" >> temp 
			echo "3) Under 'Personal access tokens' click on 'Generate new token'" >> temp
			echo "4) Click on 'Note' and enter 'hub for <your computer's name>'" >> temp
			echo "5) Click on 'repo', 'workflow', 'gist' , and 'delete_repo' checkbox" >> temp
			echo "6) Scroll down, click on 'Generate token' and copy the access token" >> temp
			echo "---------------------------------------------------------------" >> temp
			echo -ne "\nTo exit: click Crtl+x" >> temp
			nano temp
			rm temp
			echo -n "Do you want to enter generated token? (Y/n): "
			read choice
			echo -ne "\033[A\033[2K\r"
			if [[ $choice == 'Y' || $choice == 'y' ]]
			then
				echo -n "Enter your generated token: "
				read token
				echo -ne "\033[A\033[2K\r" && cd ~/.config/
				echo -n "Enter your github username: " && read username
				echo -ne "\033[A\033[2K\r"
				touch hub && echo "github.com:" >> hub && echo "- user: $username" >> hub && echo "  oauth_token: $token" >> hub && echo "  protocol: https" >> hub
				cd && cd $DIRECTORY/$name
				hub create >/dev/null 2>&1

			else
				cd .. && rm -rf $name
				echo "Program Exit"
				sleep 1 && echo -ne "\033[A\033[2K\r"
				exit 1
			fi
		else
			echo "Created successfully"
			sleep 1 && echo -ne "\033[A\033[2K\r"
		fi
		echo -n "Do you want to create README.md? (Y/n): "
		read option
		echo -ne "\033[A\033[2K\r\033[A\033[2K\r"
		if [[ $option == 'Y' || $option == 'y' ]]
		then
			touch README.md
			echo "# $name" >> README.md && cd ..
		
		else
			echo "--- Successful ---"
			sleep 1 && echo -ne "\033[A\033[2K\r\033[A\033[2K\r"
			exit 0
		fi
	elif [ $repository == 'Pr' ] || [ $repository == 'pr' ] || [ $repository == 'PR' ] || [ $repository == 'pR' ]
	then
		if ! (hub create -p 2>/dev/null) ;
		then
			echo -ne "\033[A\033[2K\r\033[A\033[2K\r"
			touch temp
			echo "---------------------------------------------------------------" >> temp
			echo "First time user, login to your github account and do the following:" >> temp
			echo "1) Under 'Settings' click on 'Developer settings'" >> temp
			echo "2) Under 'Developer settings' click on Personal access tokens" >> temp 
			echo "3) Under 'Personal access tokens' click on 'Generate new token'" >> temp
			echo "4) Click on 'Note' and enter 'hub for <your computer's name>'" >> temp
			echo "5) Click on 'repo', 'workflow', 'gist', and 'delete_repo' checkbox" >> temp
			echo "6) Scroll down, click on 'Generate token', and copy the access token" >> temp
			echo "---------------------------------------------------------------" >> temp
			echo -ne "\nTo exit: click Crtl+x" >> temp
			nano temp
			rm temp		
			echo -n "Do you want to enter generated token? (Y/n): "
			read choice
			echo -ne "\033[A\033[2K\r"
			if [[ $choice == 'Y' || $choice == 'y' ]]
			then
				echo -n "Enter your generated token: "
				read token
				echo -ne "\033[A\033[2K\r" && cd ~/.config/
				echo -n "Enter your github username: " && read username
				echo -ne "\033[A\033[2K\r"
				touch hub && echo "github.com:" >> hub && echo "- user: $username" >> hub && echo "  oauth_token: $token" >> hub && echo "  protocol: https" >> hub
				cd && cd $DIRECTORY/$name
				hub create -p >/dev/null 2>&1

			else
				cd .. && rm -rf $name
				echo "Program Exit"
				sleep 1 && echo -ne "\033[A\033[2K\r"
				exit 1
			fi
		else
			echo "Created successfully"
			sleep 1 && echo -ne "\033[A\033[2K\r"
		fi
		echo -n "Do you want to create README.md? (Y/n): "
		read option
		echo -ne "\033[A\033[2K\r\033[A\033[2K\r"
		if [[ $option == 'Y' || $option == 'y' ]]
		then
			touch README.md
			echo "# $name" >> README.md && cd ..
		
		else
			echo "--- Successful ---"
			sleep 2 && echo -ne "\033[A\033[2K\r\033[A\033[2K\r"
			exit 0
		fi
	else
		rm -rf $name
		echo "Error, Program Exit"
		echo "--- Unsuccessful ---"
		sleep 1 && echo -ne "\033[A\033[2K\r\033[A\033[2K\r"	
		exit 1
	fi

	# pushing local files to repository

	if [ "$(ls -A $name)" ]
	then
		echo -n "Do you want to push files to repository? (Y/n): "
		read option
		echo -ne "\033[A\033[2K\r" && cd $name

		if [ $option == 'Y' ] || [ $option == 'y' ]
		then 
			git add .
			echo -n "Enter a comment to commit: "
			read comment
			echo -ne "\033[A\033[2K\r"
			git commit -m "$comment" >/dev/null 2>&1
			git branch -M main >/dev/null 2>&1
			git push -u origin main >/dev/null 2>&1
			echo "--- Successful ---"
			sleep 2 && echo -ne "\033[A\033[2K\r\033[A\033[2K\r"		
			exit 0

		elif [ $option == 'N' ] || [ $option == 'n' ]
		then
			echo "--- Successful ---"
			sleep 1 && echo -ne "\033[A\033[2K\r\033[A\033[2K\r"
			exit 0
		fi
	else
		echo "--- Successful ---"
		sleep 1 && echo -ne "\033[A\033[2K\r\033[A\033[2K\r"
	fi

elif [ $input == 'D' ] || [ $input == 'd' ]
then
	echo -n "Enter name of repository to delete: "
	read delRepo
	echo -ne "\033[A\033[2K\r"
	echo "==========================================================================="
	echo "Directory list:"
	echo "---------------"
	sleep 1 && echo -ne "\033[A\033[2K\r\033[A\033[2K\r" 
	cd && ls -d */
	echo "==========================================================================="
	echo -n "Enter name of DIRECTORY where repo exists (enter . if in current dir): "
	read DIRECTORY
	counter=5
	while [ $counter -ge 0 ]
	do
		echo -ne "\033[A\033[2K\r"
		((counter-=1))
	done
	if ! (cd && cd $DIRECTORY/$delRepo >/dev/null 2>&1)
	then
		echo "Error, Repository Not Found"
		echo "--- Unsuccessful ---"
		sleep 2 && echo -ne "\033[A\033[2K\r\033[A\033[2K\r\033[A\033[2K\r"
		exit 1
	else	
		if ! (hub delete $delRepo 2>/dev/null)
		then
			echo "--- Unsuccessful ---"
			sleep 2 && echo -ne "\033[A\033[2K\r\033[A\033[2K\r\033[A\033[2K\r"
			exit 1
		else
			echo -n "Do you want to delete repository's local folder? (Y/n): "
			read optional
			echo -ne "\033[A\033[2K\r\033[A\033[2K\r"
			if [[ $optional == 'Y' || $optional == 'y' ]]	
			then
					cd && cd $DIRECTORY && rm -rf $delRepo
			fi
			echo "--- Successful ---"
			sleep 2 && echo -ne "\033[A\033[2K\r\033[A\033[2K\r\033[A\033[2K\r"
			exit 0		
		fi
	fi
else
	echo "Error, Program Exit!"
	sleep 1 && echo -ne "\033[A\033[2K\r\033[A\033[2K\r"
	exit 1
fi
