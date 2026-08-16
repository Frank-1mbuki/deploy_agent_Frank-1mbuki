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

