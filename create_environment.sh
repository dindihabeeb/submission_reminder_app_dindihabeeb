#!/bin/bash

#Ask the user for their name
echo "What is your name? "

#Accept and store the user's name in a variable using the read command
read NAME

#Store the name of the directory that will be created
user_dir="submission_reminder_$NAME"

#Create the directory
mkdir $user_dir
