#!/bin/bash
DIR=$(zenity --file-selection)
xfce4-terminal --geometry=20x10 --hide-scrollbar --hide-menubar --hide-borders -e "sh -c $DIR"
