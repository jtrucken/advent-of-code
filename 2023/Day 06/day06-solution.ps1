# Solution for Advent of Code 2023 Day 06
# Created 06 Dec 2023 by Jack Truckenmiller

# Part 1 Goal: Find the multiple of the number of possible 
# times to hold down a button on a toy boat to win a race
# Part 2 Goal: The inputs are actually one big number each.
# Find how many ways victory is possible for them.

# Input file contains race times on one line and the 
# corresponding record time on the second.

using namespace System.Collections.Generic

# Get-Content gives us these lines from the file in an array
$raceRecords = Get-Content ./day06-input.txt

# Set up queues for part 1 to keep the race times and records
# in FIFO order with each other
$times = [Queue[int]]::new()
$records = [Queue[int]]::new()
# Variables for part 2 (numbers are too big to go in the queues)
$bigTime = 0
$bigRecord = 0
# Loop through the two lines and add the numbers to their respective
# queues for part 1 and join them together to form the big numbers
# for part 2
foreach ($line in $raceRecords) {
    $lineID, $values = $line -split ": "
    $numbers = $values -split "\s+"
    foreach ($number in $numbers) {
        if ($lineID -eq "Time") {
            $times.Enqueue([int]$number)
        }
        else {
            $records.Enqueue([int]$number)
        }
    }
    $bigNumber = -join $numbers
    # Need to use Int64 for these because of their size
    if ($lineID -eq "Time") {
        $bigTime = [int64]$bigNumber
    }
    else {
        $bigRecord = [int64]$bigNumber
    }
}

# For part 1, empty out the queues, calculating the
# winning values through a simple for loop
$marginOfError = 0
while ($times.Count -gt 0) {
    $time = $times.Dequeue()
    $record = $records.Dequeue()
    $waysToWin = 0
    for ($i = 1; $i -lt $time; $i++) {
        if (($i * ($time - $i)) -gt $record) {
            $waysToWin++
        }
    }
    if ($marginOfError -eq 0) {
        $marginOfError = $waysToWin
    }
    else {
        $marginOfError *= $waysToWin
    }
}

# Same for loop as part 1, but just needs to run
# once for part 2's solution
$singleRaceWays = 0
for ($i = 1; $i -lt $bigTime; $i++) {
    if (($i * ($bigTime - $i)) -gt $bigRecord) {
        $singleRaceWays++
    }
}

Write-Host "Part 1 Solution"
Write-Host "Margin of error for races:" $marginOfError
Write-Host "Part 2 Solution"
Write-Host "Ways to win for single, big race:" $singleRaceWays
