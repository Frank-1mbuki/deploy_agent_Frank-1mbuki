#!/usr/bin/env bash                                                                
#Project Factory for the Student Attendance Tracker.                               

read -p "What is project name?" DIR_NAME

#Set up directory structure.                                                       
mkdir -p attendance_tracker_$DIR_NAME/Helpers attendance_tracker_$DIR_NAME/reports
cd attendance_tracker_$DIR_NAME
touch attendance_checker.py
touch Helpers/assets.csv
touch Helpers/config.json
touch reports/reports.log

#Prompt the user to decide if they want to update the attendance thresholds.

echo "Do you want to update attendance thresholds? (y/n)"
read UPDATE_CONF

if [ $UPDATE_CONF == "y" ]
then
    echo "Enter new warning:"
    read NEW_WARN
    echo "Enter new failure:"
    read NEW_FAIL
    
    # Trying to replace the numbers in the config file
    sed -i s/75/$NEW_WARN/g Helpers/config.json
    sed -i s/50/$NEW_FAIL/g Helpers/config.json
fi
