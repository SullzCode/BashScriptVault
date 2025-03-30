#!/bin/bash

#Prompt the user for the source directory
#Ask thr user for the backup directory
#Add a date and time stamp to the backup directory  name 
#log the backup process

source_dir=""
backup_dir=""

#Get the current date and time
current_date=$(date +"%Y-%m-%d_%H-%M-%S")

read -p "Enter the source directory to backup:" source_dir
read -p "Enter the backup directory: " backup_dir
#Check if the source directory exists

if [ ! -d "$source_dir" ]; then
    echo "Source directory does not exist."
    exit 1
fi
if [ ! -d "$backup_dir" ]; then
    echo "Backup directory does not exist."
    exit 1
fi
#Create the backup directory if it does not exist
if [ ! -d "$backup_dir" ]; then
    mkdir -p "$backup_dir"
fi

#Create a backup directory with the current date and time
backup_dir="$backup_dir/backup_$current_date"
mkdir -p "$backup_dir"

#Copy the source directory to the backup directory
cp -r "$source_dir" "$backup_dir"

#Check if the copy was successful
if [ $? -eq 0 ]; then
    echo "Backup of $source_dir to $backup_dir was successful."
else
    echo "Backup failed."
    exit 1
fi
#Log the backup process
log_file="$backup_dir/backup_log.txt"
echo "Backup of $source_dir to $backup_dir was successful on $current_date" >> "$log_file"
echo "Backup log created at $log_file"
#Check if the log file was created successfully
if [ $? -eq 0 ]; then
    echo "Log file created successfully."
else
    echo "Log file creation failed."
    exit 1
fi
#Print the backup directory
echo "Backup directory: $backup_dir"
#Print the log file
echo "Log file: $log_file"