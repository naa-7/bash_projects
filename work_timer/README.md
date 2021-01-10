# work_timer

[!work_timer][(https://github.com/naa-7/bash_projects/blob/main/work_timer/timer_image.png)]

The idea of this project is to build a terminal based work timer. The program uses zenity to ask a user for required time to start counting down. The user can enter hours and minutes,

hours without minutes, or minutes without hours since it accepts hours and minutes. There are two ways to start the timer. First, the program will run the current terminal window and 

when the program ends, the output will be removes. Second, the program will run in a new window of a set size (20x10) to save screen space for other tasks and once program ends the 

timer terminal window will close. In both ways, Once the timer stops, a 2 second alert will start and a notification pop up window will apear to notify user of the end of program.


## There are two ways to run the program

 One, The program will run in the current terminal window

   1) Change Directory to `work_timer`. Example:

     $ cd github/work_timer/

   2) Make the program executable:
    
     $ chmod +x work_timer

   3) Run the program:
 
     $ ./work_timer 

Second, The program will run in a new window which will close after the program ends:
   
   1) Change Directory to `work_timer`. Example:

     $ cd github/work_timer/

   2) Make the program & launcher executable:

     $ chmod +x work_timer launcher.sh

   3) Run `launcher.sh`:

     $ ./launcher 


