#!/bin/bash
DIR=$(zenity --file-selection)
xfce4-terminal --geometry=20x10 -e "sh -c $DIR"
