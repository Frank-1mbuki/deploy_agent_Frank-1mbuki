# Student Attendance Tracker Project Factory

## Overview
`setup_project.sh` is a shell script that automates the creation of an attendance tracking workspace, configures thresholds via the command line, and handles system signals gracefully.

## Prerequisites
- **Bash**: Required to execute the setup script.
- **Python 3**: Required to run the generated attendance tracker.

### Verify Python 3 Installation
Check if Python 3 is installed by running:
```bash
python3 --version
```

If it is not installed, run the following to install it:
```bash
sudo apt update
sudo apt install python3
```

## Execution

1. **Make the script executable:**
   ```bash
   chmod +x setup_project.sh
   ```

2. **Run the script:**
   ```bash
   ./setup_project.sh
   ```

3. **Follow the interactive prompts:**
   - Provide a project name when prompted.
   - Choose whether to update the default attendance thresholds (Warning: 75%, Failure: 50%).

> **Interrupt Handling:** You can press `Ctrl+C` at any point during setup to cancel. Before exiting, the script will bundle the current state of the project directory into an archive named `attendance_tracker_<PROJECT_NAME>_archive`.

## Generated Structure
The script creates the following directory structure upon completion:

```text
attendance_tracker_<PROJECT_NAME>/
├── attendance_checker.py      
├── Helpers/
│   ├── assets.csv             
│   └── config.json            
└── reports/
    └── reports.log
```
