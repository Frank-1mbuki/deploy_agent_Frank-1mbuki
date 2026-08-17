# Student Attendance Tracker Project Factory

## Overview
setup_project.sh is a shell script that automates the creation of the workspace, configures settings via the command line, and handles system signals gracefully.

## Prerequisites
- Bash is required to run the script
- Python 3 must be installed

## Execution
1. Make the script executable:
   chmod +x setup_project.sh
   
2. Run the script:
   ./setup_project.sh

3. Press Ctrl+C at any point during setup to cancel. Before exiting, the script bundles the current state of the project directory into an archive and named attendance_tracker_{input}_archive
   
4. Provide a project name when prompted.
5. Choose whether you want to update the attendance thresholds (Warning: 75%, Failure: 50%).

## Generated Structure
The script creates the following directory structure
attendance_tracker_<PROJECT_NAME>/
├── attendance_checker.py      
├── Helpers/
│   ├── assets.csv             
│   └── config.json            
└── reports/
    └── reports.log
