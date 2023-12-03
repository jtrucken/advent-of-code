# Solution for Advent of Code 2023 Day 02
# Created 02 Dec 2023 by Jack Truckenmiller

# Part 1 Goal: Find the sum of game IDs which match possible games
# Part 2 Goal: Find the sum of set powers for the minimum number of
# cubes required for each game to be playable

# Input file contains single lines of games with IDs as well as sets
# of colored cubes drawn, split by semicolons with the invidual cube
# values separated by commas

# Get-Content gives us these lines from the file in an array
$games = Get-Content ./day02-input.txt

# Simple hashtable for comparing the limits on each color later
$cubeLimit = @{
    "red" = 12;
    "green" = 13;
    "blue" = 14
}
$sumOfIDs = 0
$sumOfSetPower = 0
# No need to split out the game ID since they start at 1 and add 1 from
# from there. A counter variable can get the job done
$i = 1
# Loop through the lines of games, determing if the game is possible 
# based on the cube limit defined in the hashtable above as well as finding
# the set power for the minimum required cubes of each color for each game
foreach ($game in $games) {
    $possibleGame = $true
    # These lists will hold the number of cubes for each round in each game
    $redCubes = [System.Collections.Generic.List[int]]::new()
    $greenCubes = [System.Collections.Generic.List[int]]::new()
    $blueCubes = [System.Collections.Generic.List[int]]::new()
    # Lots of string splitting to get our values. First, we want to get
    # rid of Game i which is delimted by a colon and a space
    $gameID, $cubeSetsString = $game -split ": "
    # Next divide the sets of rounds by splitting on their delimiter a
    # semicolon divided by a space
    $cubeSets = $cubeSetsString -split "; "
    # Loop through the individual sets, and determine if any of their 
    # cube counts violate the defined limits
    foreach ($cubeSet in $cubeSets) {
        $cubes = $cubeSet -split ", "
        foreach ($cube in $cubes) {
            $cubeCount, $cubeColor = $cube -split ' '
            if ([int]$cubeCount -gt $cubeLimit[$cubeColor]) {
                $possibleGame = $false
            }
            # Filter the number of cubes for the game into the appropriate
            # list based on the color
            switch ($cubeColor) {
                "red" {
                    $redCubes.Add([int]$cubeCount)
                }
                "green" {
                    $greenCubes.Add([int]$cubeCount)
                }
                "blue" {
                    $blueCubes.Add([int]$cubeCount)
                }
            }
        }
    }
    if ($possibleGame) {
        $sumOfIDs += $i
    }
    $i++
    # Sort the lists, then the highest value is the number we want for each
    # color. Multiply these values together and add the result to the sum of
    # the set powers
    $redCubes.Sort()
    $redValue = $redCubes[$redCubes.Count -1]
    $greenCubes.Sort()
    $greenValue = $greenCubes[$greenCubes.Count -1]
    $blueCubes.Sort()
    $blueValue = $blueCubes[$blueCubes.Count -1]
    $sumOfSetPower += ($redValue * $greenValue * $blueValue)
}
Write-Host "Part 1 Solution"
Write-Host "Sum of possible game IDs:" $sumOfIDs
Write-Host "Part 2 Solution"
Write-Host "Sum of set powers:" $sumOfSetPower