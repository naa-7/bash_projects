#!/bin/bash

# small program for working with git repositories

# user input for commit comment
if ! (dpkg -s zenity >/dev/null 2>&1) && ! (rpm -q zenity >/dev/null 2>&1) && ! (yum list installed zenity >/dev/null 2>&1) && ! (dnf list installed zenity >/dev/null 2>&1) && ! (which zenity >/dev/null 2>&1) ;
then
  echo -n "Enter a comment to commit changes: "
  read comment
  echo -ne "\033[A\033[2K\r"
else
  comment=$(zenity --title="Git Repository" --entry --text="Enter a comment to commit changes:")
fi
# adding files
git add .

# commiting changes
git commit -m $comment
sleep 1 && echo -ne "\033[A\033[2K\r\033[A\033[2K\r"

# pushing to repository
if (git push >/dev/null 2>&1) ;
then
	echo "--- Successful ---"
	sleep 1 && echo -ne "\033[A\033[2K\r\033[A\033[2K\r"
else
	echo "--- Failed ---"
	sleep 1 && echo -ne "\033[A\033[2K\r"
fi
