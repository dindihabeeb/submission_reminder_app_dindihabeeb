# Submission Reminder App Setup Script

## Overview
This repository contains a shell script (`create_environment.sh`) that sets up a directory structure for the Submission Reminder App. The script creates a personalized environment that helps track student assignment submissions and sends reminders for pending submissions.

## Features
- Creates a structured application directory
- Sets up configuration files
- Initializes sample submission data
- Configures executable permissions automatically
- Provides a startup script for easy execution

## Directory Structure
```
submission_reminder_[username]/
├── app/
│   └── reminder.sh         # Main application script
├── modules/
│   └── functions.sh        # Helper functions
├── assets/
│   └── submissions.txt     # Sample submission data
├── config/
│   └── config.env         # Environment configuration
└── startup.sh             # Application launcher
```

## Setup Instructions

1. Clone this repository:
   ```bash
   git clone [repository-url]
   ```

2. Navigate to the repository directory:
   ```bash
   cd [repository-directory]
   ```

3. Make the setup script executable:
   ```bash
   chmod +x create_environment.sh
   ```

4. Run the setup script:
   ```bash
   ./create_environment.sh
   ```

5. When prompted, enter your name. The script will create a personalized directory structure.

## Script Explanation

### create_environment.sh
- Prompts for user input to personalize the environment
- Creates the main application directory and subdirectories
- Generates necessary files with appropriate permissions
- Sets up sample data and configuration files
- Creates and configures a startup script

### Key Components
1. **reminder.sh**: Main application script that:
   - Sources configuration and functions
   - Displays assignment information
   - Checks submission status

2. **functions.sh**: Contains helper functions for:
   - Reading submission files
   - Processing student submission status
   - Generating reminders

3. **config.env**: Configuration file containing:
   - Assignment name
   - Submission deadline information

4. **submissions.txt**: Sample data file with:
   - Student names
   - Assignment details
   - Submission status

## Usage
After setup, you can run the application using:
```bash
./submission_reminder_[username]/startup.sh
```

## File Permissions
The script automatically sets the following permissions:
- Execute permissions for all `.sh` files
- Read permissions for configuration and data files

## Requirements
- Bash shell environment
- Basic file system permissions
- Read/Write access to the current directory

## Conclusion
This repo is contains the solution to the summative assessment for trimester 2 BSE Sept. 2024
