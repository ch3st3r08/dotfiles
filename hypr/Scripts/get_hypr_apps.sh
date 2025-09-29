#!/bin/bash

filename="$HOME/.config/hypr/hyprland.conf"

# Check if file exists
if [ ! -f "$filename" ]; then
    echo "Error: File '$filename' not found."
    exit 1
fi

# Flag to track if we're inside the apps submap
inside_apps_submap=false

# Variable to collect all results
results=""

# Read the file line by line
while IFS= read -r line; do
    # Check if we found the submap=apps line
    if [[ "$line" == "submap=apps" ]]; then
        inside_apps_submap=true
        continue
    fi
    
    # If we're inside the apps submap
    if [ "$inside_apps_submap" = true ]; then
        # Check if we hit the escape/reset line
        if [[ "$line" == "binde=,escape,submap,reset" ]]; then
            break
        fi
        
        # Parse bind lines
        if [[ "$line" =~ ^bindd= ]]; then
            # Remove 'bindd=' prefix and split by commas
            line_content="${line#bindd=}"
            
            # Use IFS to split the line by commas
            IFS=',' read -ra PARTS <<< "$line_content"
            
            # Extract the key (second part after first comma) and description (third part)
            if [ ${#PARTS[@]} -ge 3 ]; then
                key="${PARTS[1]}"
                description="${PARTS[2]}"
                
                # Append to results variable with newline
                if [ -z "$results" ]; then
                    results="$key --> $description"
                else
                    results="$results"$'\n'"$key --> $description"
                fi
            fi
        fi
    fi
done < "$filename"

notify-send --app-name="Hyprland" "System" "$results"
