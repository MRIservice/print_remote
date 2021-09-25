#!/bin/bash

############################################################################################################
# This script will transfer a file from a localhost to a
# remote host so that it can be printed.
#
# This script was written in response to depreciated phyton modules used in HPLIP 
# preventing new cups installations to work.
#
# This script is intended to be a workaround until HP updates HPLIP so that it does not require 
# depreciated python dependencies.  However this script is quite useful for sharing a common print server.
#
# This script requires a working or legacy cups installation that does not have the dependencie problem.
# This script works best when using encription key authentication.  
# Use Ip addresses or  hosts defined in .ssh/config 
# This script has only been LAN tested.
#
#############################################################################################################

while : 
do

# Define file to print#
echo
echo -n "What is the name of the file to print? "
read FILE
echo

# check to see if file exists on local host
if [ -f "$FILE" ]; then
        break
else 
    echo "$FILE does not exist."
fi
done

# define remote print host parameters
echo -n "What is the name (defined in .ssh/config) or IP address of the print server host? "
read print_host
echo
echo -n "What is the username on the print host? "
read user_name
echo

# transfer file to remote host
rsync -av $FILE $user_name@$print_host:$FILE

# connect to the remote server and print the file
echo -e "Lets make the connection \n..........\n..............\n\n"
ssh $user_name@$print_host 'lpr '$FILE''