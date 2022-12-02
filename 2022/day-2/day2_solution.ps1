# Solution for Advent of Code 2022 Day 2
# Created 2 Dec 2022 by Jack Truckenmiller

# Part 1 Goal: Find the final score in a tournament of Rock Paper Scissors using a
# strategy guide to decide which shape to play in response to the opponents shape
# Part 2 Goal: Find the final score in a tournament of Rock Paper Scissors using a
# strategy guide to decide whether to win, lose, or draw in response to the opponent's
# chosen shape

# Function that returns a single round score based on the provided strategy and which
# part of the puzzle we are trying to solve
function Measure-Score {

    param (
        [Parameter(Mandatory)]
        [string]$InputString,

        [Parameter(Mandatory)]
        [int]$SolutionForPart
    )

    switch ($SolutionForPart) {
        1 { $scoreValues = @(4, 8, 3, 1, 5, 9, 7, 2, 6) }
        2 { $scoreValues = @(3, 4, 8, 1, 5, 9, 2, 6, 7) }
    }

    switch ($InputString) {
        "A X" { return $scoreValues[0] } # Rock Rock (Part 1) Rock Lose [You choose Scissors] (Part 2)
        "A Y" { return $scoreValues[1] } # Rock Paper (Part 1) Rock Draw [You choose Rock] (Part 2)
        "A Z" { return $scoreValues[2] } # Rock Scissors (Part 1) Rock Win [You choose Paper] (Part 2)
        "B X" { return $scoreValues[3] } # Paper Rock (Part 1) Paper Lose [You choose Rock] (Part 2)
        "B Y" { return $scoreValues[4] } # Paper Paper (Part 1) Paper Draw [You choose Paper] (Part 2)
        "B Z" { return $scoreValues[5] } # Paper Scissors (Part 1) Paper Win [You choose Scissors] (Part 2)
        "C X" { return $scoreValues[6] } # Scissors Rock (Part 1) Scissors Lose [You choose Paper] (Part 2)
        "C Y" { return $scoreValues[7] } # Scissors Paper (Part 1) Scissors Draw [You choose Scissors] (Part 2)
        "C Z" { return $scoreValues[8] } # Scissors Scissors (Part 1) Scissors Win [You choose Rock] (Part 2)
    }
}

# Input file contains single lines of either A, B, or C followed by a whitespace and then either X, Y, or Z
# A represents the opponent using Rock, B Paper, and C Scissors
# X, Y, and Z are the player's response, and they vary in meaning depending on the part of the puzzle being
# solved

# Get-Content gives us these lines from the file in an array
$strategyGuide = Get-Content .\2022\day-2\input.txt

# Loops through each line to sum up the scores for each part
$finalScore1 = 0
$finalScore2 = 0
foreach ($line in $strategyGuide) {
    # X = Rock (1 point), Y = Paper (2 points), Z = Scissors (3 points)
    $finalScore1 += Measure-Score -InputString $line -SolutionForPart 1
    # X = Lose, Y = Draw, Z = Win. Point values for the shape needed to achieve the result are maintained from Part 1
    $finalScore2 += Measure-Score -InputString $line -SolutionForPart 2
}

Write-Host "Part 1 Solution"
Write-Host "The final score in the tournament for the strategy guide is: ${finalScore1} points."

Write-Host "Part 2 Solution"
Write-Host "The final score in the tournament for the updated strategy guide is: ${finalScore2} points."