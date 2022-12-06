# Solution for Advent of Code 2022 Day 6
# Created 6 Dec 2022 by Jack Truckenmiller

# Part 1 Goal: Find the number of characters in a single string there are before ending with a
# group of four distinct characters (they are also included in the cound)
# Part 2 Goal: Same as above but with 14 distinct characters instead of 4.

# Function contains the main logic behind the solve, allowing for dynamic amount of distinct
# characters to be checked
function Find-Marker {

    param(
        [Parameter(Mandatory)]
        [array]$CharArray,

        [Parameter(Mandatory)]
        [int]$NumberCharsDistinct
    )

    # The Queue is used for holding the current collection of characters that are being checked
    # for distinctness
    $markerCharacters = [System.Collections.Generic.Queue[char]]::new()
    $characterCounter = 0
    
    # Loop through the array of characters and check for the desired number to be distinct until
    # a collection matching this condition is found
    foreach ($character in $CharArray) {
        # Add to the queue initially until the first collection to check is built
        if ($markerCharacters.Count -lt $NumberCharsDistinct) {
            $markerCharacters.Enqueue($character)
        }
        else {
            # Turns the Queue into an array of unique entries. If the number of objects in the
            # array matches the deisred number of distinct objects, then end the foreach loop.
            # Otherwise, drop the first entry of the queue and add in the latest checked character
            $uniqueCharacters = $markerCharacters.ToArray() | Select-Object -Unique
            if ($uniqueCharacters.Count -eq $NumberCharsDistinct) {
                break
            }
            else {
                $markerCharacters.Dequeue() | Out-Null
                $markerCharacters.Enqueue($character)
            }
        }
        $characterCounter++
    }
    
    return $characterCounter
}

# Our input is a single string of characters representing the data stream we are receiving

# Get-Content imports the string
$dataStream = Get-Content .\2022\day-6\input.txt

# .ToCharArray() splits the string into an array of characters
$dataStreamArray = $dataStream.ToCharArray()
# Uses the function to get counts for parts 1 & 2
$solution1 = Find-Marker -CharArray $dataStreamArray -NumberCharsDistinct 4
$solution2 = Find-Marker -CharArray $dataStreamArray -NumberCharsDistinct 14

Write-Host "Part 1 Solution"
Write-Host "${solution1} characters need to be processed before the first start-of-packet marker is detected."

Write-Host "Part 2 Solution"
Write-Host "${solution2} characters need to be processed before the first start-of-message marker is detected."