#!/bin/bash

# Check if both arguments are provided
if [ $# -ne 2 ]; then
  echo "Usage: $0 <owner> <repo>"
  exit 1
fi

owner=$1
repo=$2

# Use a more portable date command
cutoff_date=$(date -u -v-6m +%s)

# Get all branches except the default (main or master)
branches=$(gh api repos/$owner/$repo/branches --paginate --jq '.[] | select(.name != "main") | .name')

# Array to store stale branches
stale_branches=()

echo "Checking for stale branches..."

# Loop over each branch and check the last commit date
for branch in $branches; do
  # Get the last commit date
  last_commit_date=$(gh api repos/$owner/$repo/branches/$branch --jq '.commit.commit.author.date')

  # Convert ISO 8601 date to Unix timestamp
  last_commit_timestamp=$(date -u -j -f "%Y-%m-%dT%H:%M:%SZ" "$last_commit_date" "+%s" 2>/dev/null)

  if [ $? -ne 0 ]; then
    echo "Error: Failed to parse date for branch $branch"
    continue
  fi

  if [ $last_commit_timestamp -lt $cutoff_date ]; then
    stale_branches+=("$branch|$last_commit_date")
  fi
done

# If no stale branches found, exit
if [ ${#stale_branches[@]} -eq 0 ]; then
  echo "No stale branches found."
  exit 0
fi

# Display all stale branches
echo "The following branches are stale:"
for branch_info in "${stale_branches[@]}"; do
  IFS='|' read -r branch date <<< "$branch_info"
  echo "- $branch (last commit: $date)"
done

# Prompt for confirmation
read -p "Do you want to delete all these branches? (y/N): " confirm

if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
  echo "Deleting stale branches..."
  for branch_info in "${stale_branches[@]}"; do
    IFS='|' read -r branch date <<< "$branch_info"
    echo "Deleting branch $branch"
    gh api -X DELETE repos/$owner/$repo/git/refs/heads/$branch
    if [ $? -eq 0 ]; then
      echo "Branch $branch deleted successfully"
    else
      echo "Failed to delete branch $branch"
    fi
  done
  echo "Deletion process completed."
else
  echo "Operation cancelled. No branches were deleted."
fi
