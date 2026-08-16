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

#Write attendance_checker.py
cat <<EOF > attendance_checker.py

import csv
import json
import os
from datetime import datetime

def run_attendance_check():
    # 1. Load Config
    with open('Helpers/config.json', 'r') as f:
        config = json.load(f)
    
    # 2. Archive old reports.log if it exists
    if os.path.exists('reports/reports.log'):
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        os.rename('reports/reports.log', f'reports/reports_{timestamp}.log.archive')

    # 3. Process Data
    with open('Helpers/assets.csv', mode='r') as f, open('reports/reports.log', 'w') as log:
        reader = csv.DictReader(f)
        total_sessions = config['total_sessions']
        
        log.write(f"--- Attendance Report Run: {datetime.now()} ---\n")
        
        for row in reader:
            name = row['Names']
            email = row['Email']
            attended = int(row['Attendance Count'])
            
            # Simple Math: (Attended / Total) * 100
            attendance_pct = (attended / total_sessions) * 100
            
            message = ""
            if attendance_pct < config['thresholds']['failure']:
                message = f"URGENT: {name}, your attendance is {attendance_pct:.1f}%. You will fail this class."
            elif attendance_pct < config['thresholds']['warning']:
                message = f"WARNING: {name}, your attendance is {attendance_pct:.1f}%. Please be careful."
            
            if message:
                if config['run_mode'] == "live":
                    log.write(f"[{datetime.now()}] ALERT SENT TO {email}: {message}\n")
                    print(f"Logged alert for {name}")
                else:
                    print(f"[DRY RUN] Email to {email}: {message}")

if __name__ == "__main__":
    run_attendance_check()" > "$DIR_NAME/attendance_checker.py"
EOF

    
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

#Signal Trap to handle user interrupts (SIGINT/Ctrl+C)

echo "Setting up the interrupt trap..."

function catch_cancel() {
    echo "Script cancelled! Going back..."

    rm -rf attendance_tracker_$DIR_NAME
}

trap catch_cancel SIGINT
