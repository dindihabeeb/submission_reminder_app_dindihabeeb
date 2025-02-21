#!/bin/bash

#Ask the user for their name
echo "What is your name? "

#Accept and store the user's name in a variable using the read command
read NAME

#Store the name of the directory that will be created
user_dir="submission_reminder_$NAME"

#Create the directory
mkdir $user_dir

#Create the sub-directories
mkdir $user_dir/{app,modules,assets,config}

#WAY 1
#Create the files using the touch command
#touch $user_dir/app/reminder.sh
#touch $user_dir/modules/functions.sh
#touch $user_dir/assetssubmissions.txt
#touch $user_dir/config/config.env

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
EOF

#Provide execute permissions to created files
chmod u+x $user_dir/app/reminder.sh
chmod u+x $user_dir/modules/functions.sh
chmod u+x $user_dir/config/config.env


#Create startup.sh file that will execute reminder.sh
cat <<EOF > $user_dir/startup.sh
#!/bin/bash
cd $user_dir
./app/reminder.sh
EOF

#Provide execute permissions to startup.sh
chmod u+x $user_dir/startup.sh

#Execute startup.sh which in turn execute reminder.sh
./$user_dir/startup.sh
