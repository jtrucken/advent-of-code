#!/bin/bash

# Solution for Advent of Code 2022 Day 4
# Created 4 Dec 2022 by Jack Truckenmiller

# Part 1 Goal: Find how many pairs of ranges had one of the ranges contained within the other
# Part 2 Goal: Find how many pairs of ranges overlaped one another

containsTotal=0
overlapTotal=0

# The input 

# while loop in Bash is the best way to read in the file input
while read line
do
    # IFS combined with read -ra <variableName> creats string arrays from strings split on delimited declared to IFS
    IFS=','
    read -ra commaSplit <<< "$line"
    IFS='-'
    read -ra firstRange <<< "${commaSplit[0]}"
    read -ra secondRange <<< "${commaSplit[1]}"

    # || represents logical OR 
    # Left hand side of the OR is if the first range contains the second range
    # Right hand side of the OR is if the second range contains the first
    if [[ (${firstRange[0]} -le ${secondRange[0]} && ${firstRange[1]} -ge ${secondRange[1]}) || (${firstRange[0]} -ge ${secondRange[0]} && ${firstRange[1]} -le ${secondRange[1]}) ]]
    then
        (( containsTotal += 1 ))
    # We need to find overlapping ranges for Part 2. This checks if the start of the second range overlaps with the end of the
    # first or if the start of the first range overlaps the end of the second
    elif [[ (${firstRange[0]} -le ${secondRange[0]} && ${firstRange[1]} -ge ${secondRange[0]}) || (${firstRange[0]} -ge ${secondRange[0]} && ${firstRange[0]} -le ${secondRange[1]}) ]]
    then
        (( overlapTotal += 1 ))
    fi
done < "input.txt"

# Ranges contained within the other count as overlaps as well, so add the two counts together for true number of overlaps
overlapTotal=$(( $containsTotal + $overlapTotal ))

echo "Part 1 Solution"
echo "The number of assignment pairs where one range fully contains the other is: ${containsTotal}."
echo ""
echo "Part 2 Solution"
echo "The number of assignment pairs that overlap is: ${overlapTotal}."