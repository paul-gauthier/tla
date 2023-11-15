#!/bin/bash

# Function to generate all possible acronyms of a given length iteratively
generate_acronyms() {
  local length=$1
  local chars="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  local count=$((26**length))
  for (( i=0; i<count; i++ )); do
    local num=$i
    local acronym=""
    for (( j=0; j<length; j++ )); do
      local idx=$((num % 26))
      acronym="${chars:$idx:1}$acronym"
      num=$((num / 26))
    done
    echo "$acronym"
  done
}

# Function to check if an acronym is in use on Wikipedia
check_acronym() {
  local acronym=$1
  local response=$(curl -s "https://en.wikipedia.org/w/api.php?action=query&titles=$acronym&format=json")

  if [[ $response == *"\"missing\""* ]]; then
    echo "Acronym $acronym is not in use on Wikipedia."
  else
    echo "Acronym $acronym is in use on Wikipedia."
  fi
}

# Main loop to check acronyms of length 1 to 6
for length in {1..6}; do
  generate_acronyms $length | while read -r acronym; do
    check_acronym "$acronym"
  done
done
