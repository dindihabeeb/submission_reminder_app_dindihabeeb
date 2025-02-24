#!/bin/bash

#####################################################################
# Script Name: create_environment.sh
# Description: Sets up a submission reminder application environment
#              Creates necessary directory structure and configuration
# Author: Habeeb Dindi
# Date: Current
#####################################################################



#############
# User Input #
#############

# Prompt for user's name
echo "What is your name? "
read NAME


############################
# Directory Structure Setup #
############################

# Define directory structure
user_dir="submission_reminder_$NAME"

# Create main directory
mkdir "$user_dir" 

# Create subdirectories
echo "Creating application directory structure..."
mkdir -p "$user_dir"/{app,modules,assets,config}"

#########################
# File Content Creation #
#########################

# Create application files with their contents
# Note: Using heredoc (EOF) to create files with specific content


#Create and add the appropriate contents to the file
cat <<'EOF' > $user_dir/app/reminder.sh
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file 
EOF


cat <<'EOF' >  $user_dir/modules/functions.sh 
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF


cat <<'EOF' > $user_dir/config/config.env
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

cat <<'EOF' > $user_dir/assets/submissions.txt
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Habeeb, Shell Navigation, not submitted
Gilbert, Python, not submitted
Vanessa, Shell Basics, submitted
Divine, Shell Navigation, not submitted
Placide, SQL and NoSQL, submitted
EOF

######################
# Set File Permissions #
######################

echo "Setting file permissions..."
# Make scripts executable
chmod u+x "$user_dir/app/reminder.sh"
chmod u+x "$user_dir/modules/functions.sh"
chmod u+x "$user_dir/config/config.env"

#########################
# Create Startup Script #
#########################

# Create and configure startup script
echo "Creating startup script..."
cat <<EOF > "$user_dir/startup.sh"
#!/bin/bash
cd $user_dir
./app/reminder.sh
EOF

# Make startup script executable
chmod u+x "$user_dir/startup.sh"

####################
# Run Application #
####################

echo "Starting the application..."
./"$user_dir/startup.sh"
