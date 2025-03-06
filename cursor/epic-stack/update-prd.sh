#!/bin/bash

# Script to update the project structure in the PRD file

# Define paths
PRD_FILE=".cursor/rules/prd.mdc"
TEMP_FILE="/tmp/prd_temp.mdc"
STRUCTURE_FILE="/tmp/structure.txt"
PREV_STRUCTURE_FILE="/tmp/prev_structure.txt"

# Function to update the PRD file
update_prd() {
  echo "Updating project structure in PRD..."

  # Generate the current structure using tree and save to a file
  tree -L 3 -I "node_modules|build|.git" --dirsfirst > "$STRUCTURE_FILE"

  # Check if the structure has changed since last update
  if [ -f "$PREV_STRUCTURE_FILE" ] && diff -q "$STRUCTURE_FILE" "$PREV_STRUCTURE_FILE" > /dev/null; then
    echo "No changes in project structure. Skipping update."
    return
  fi

  # Save current structure for future comparison
  cp "$STRUCTURE_FILE" "$PREV_STRUCTURE_FILE"

  # Create a new temporary file
  > "$TEMP_FILE"

  # Process the PRD file line by line
  in_structure_section=0
  found_structure_section=0
  while IFS= read -r line; do
    if [[ "$line" == "## Project Structure" ]]; then
      # Found the Project Structure section
      echo "## Project Structure" >> "$TEMP_FILE"
      echo "" >> "$TEMP_FILE"
      echo '```' >> "$TEMP_FILE"
      cat "$STRUCTURE_FILE" >> "$TEMP_FILE"
      echo '```' >> "$TEMP_FILE"
      echo "" >> "$TEMP_FILE"
      in_structure_section=1
      found_structure_section=1
    elif [[ "$in_structure_section" -eq 1 && "$line" =~ ^### ]]; then
      # Found the next section after Project Structure
      echo "$line" >> "$TEMP_FILE"
      in_structure_section=0
    elif [[ "$in_structure_section" -eq 0 ]]; then
      # Not in Project Structure section, copy the line
      echo "$line" >> "$TEMP_FILE"
    fi
  done < "$PRD_FILE"

  # If Project Structure section wasn't found, add it after Database Schema
  if [[ "$found_structure_section" -eq 0 ]]; then
    awk '/## Implementation Plan/{
      print;
      while(getline && !/^##/){print}
      print "## Project Structure\n";
      print "```";
      system("cat '"$STRUCTURE_FILE"'");
      print "```\n";
      print;
      next;
    }1' "$TEMP_FILE" > "${TEMP_FILE}.new"
    mv "${TEMP_FILE}.new" "$TEMP_FILE"
  fi

  # Replace the original file with the updated one
  mv "$TEMP_FILE" "$PRD_FILE"

  echo "Project structure updated successfully."
}

# Run the update once
update_prd

# If --watch flag is provided, start watching for changes
if [ "$1" == "--watch" ]; then
  echo "Starting watch mode. Press Ctrl+C to stop."
  
  # Check if fswatch is installed
  if ! command -v fswatch &> /dev/null; then
    echo "Error: fswatch is not installed."
    echo "Please install fswatch to use the watch mode:"
    echo ""
    echo "  macOS:   brew install fswatch"
    echo "  Ubuntu:  sudo apt-get install fswatch"
    echo "  Fedora:  sudo dnf install fswatch"
    echo ""
    echo "After installing, run this script again with the --watch flag."
    exit 1
  else
    # Use fswatch for file watching
    fswatch -e "node_modules" -e ".git" -e "build" -o . | while read; do
      # Run the update function
      update_prd
    done
  fi
fi 