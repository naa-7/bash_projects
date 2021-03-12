#!/bin/bash

while [[ true ]]
do

	echo "============================================================"
	echo "                     Git Repo Utility                       "
	echo "============================================================"
	echo  "Options:"
	echo "------------------------------------------------------------"
	echo -e "\n[1] Pull without changing local - [2] Remove local changes"
	echo -e "[3] Push changes - [4] Pull changes - [5] Quit\n"
	echo "------------------------------------------------------------"
	echo "Enter Option Nubmer: "
	echo "============================================================"
	echo -ne "\033[2A\033[K\rEnter Option Number: "
	read input && echo ""

	for i in {1..12}
	do	
		echo -ne "\033[A\033[K\r"
	done

	if [[ $input == 1 ]]
	then
		# git pull is basically git fetch && git merge 
		#git stash apply // if git stash pop doesn't work, then git stash apply works the same way
		if (git stash >/dev/null 2>&1) && (git pull >/dev/null 2>&1) && (git stash pop >/dev/null 2>&1) && (git stash drop >/dev/null 2>&1)
		then
			echo -e "\033[30;48;5;82m--- Successful ---\033[0m"
			sleep 1.5 && echo -ne "\033[A\033[2K\r"
			break

		else
			echo -e "\033[30;41;5;82m--- Failed ---\033[0m"
			sleep 1.5 && echo -ne "\033[A\033[2K\r"
		fi

	elif [[ $input == 2 ]]
	then
		if (git fetch >/dev/null 2>&1) && (git reset --hard HEAD >/dev/null 2>&1) && (git merge >/dev/null 2>&1)
		then
			echo -e "\033[30;48;5;82m--- Successful ---\033[0m"
			sleep 1.5 && echo -ne "\033[A\033[2K\r"
			break

		else
			echo -e "\033[30;41;5;82m--- Failed ---\033[0m"
			sleep 1.5 && echo -ne "\033[A\033[2K\r"
		fi

	elif [[ $input == 3 ]]
	then
		#if ! (dpkg -s zenity >/dev/null 2>&1) && ! (rpm -q zenity >/dev/null 2>&1) && ! (yum list installed zenity >/dev/null 2>&1) && ! (dnf list installed zenity >/dev/null 2>&1) && ! (which zenity >/dev/null 2>&1) ;
		#then
			echo -n "Enter a comment to commit changes: "
			read comment
			echo -ne "\033[A\033[2K\r"

		#else
		#	comment='$(zenity --title="Git Repository" --entry --text="Enter a comment to commit changes:")'
		#fi

		# adding files
		git add . >/dev/null 2>&1

		# commiting changes
		git commit -m $comment >/dev/null 2>&1

		# pushing to repository
		if (git push >/dev/null 2>&1) ;
		then
			echo -e "\033[30;48;5;82m--- Successful ---\033[0m"
			sleep 1.5 && echo -ne "\033[A\033[2K\r"
			break

		else
			echo -e "\033[30;41;5;82m--- Failed ---\033[0m"
			sleep 1.5 && echo -ne "\033[A\033[2K\r"
		fi

	elif [[ $input == 4 ]]
	then
		if (git pull --no-edit >/dev/null 2>&1)
		then
			echo -e "\033[30;48;5;82m--- Successful ---\033[0m"
			sleep 1.5 && echo -ne "\033[A\033[2K\r"
			break

		else
			echo -e "\033[30;41;5;82m--- Failed ---\033[0m"
			sleep 1.5 && echo -ne "\033[A\033[2K\r"
		fi

	elif [[ $input == 5 || $input == 'Q' || $input == 'q' ]]
	then
		echo -e "\033[30;48;5;82m--- Program Exit ---\033[0m" && sleep 1.5 && echo -ne "\033[A\033[2K\r" && break

	else
		echo -e "\033[30;41;2;82m--- Error, Wrong Entry ---\033[0m"&& sleep 1.5 && echo -ne "\033[A\033[2K\r"	
	fi
done






