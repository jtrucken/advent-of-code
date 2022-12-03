# Day 2: Rock Paper Scissors

Day 2's puzzle involved calculating score of each round in a tournament of rock paper scissors. You can view the full description of the puzzle at the Advent of Code website: [Day 2 - Advent of Code 2022](https://adventofcode.com/2022/day/2). I solved this puzzle using PowerShell.

## Part 1

For part 1, we needed to interpret the encrypted strategy guide we are given by one of the elves in order to win the rock paper scissors tournament convincingly (meaning we can't just win every time). The guide is contained in the `input.txt` file for todays puzzle. Each strategy is a single line of the pattern **A**, **B**, or **C** followed by a whitespace and then **X**, **Y**, or **Z**. I once again used `Get-Content` to pull the input files contents into an array before looping through the lines with `foreach`. For my initial solve of part 1, I simply had a storage variable `$finalScore` that was initialized with a value of `0` and then appended to with new values based on pattern matching a `switch` block of the nine possible patterns and their point values, which gave me the final summed score. Here is what that code looked like:

```powershell

$strategyGuide = Get-Content .\2022\day-2\input.txt

$finalScore = 0
foreach ($line in $strategyGuide) {
    $finalScore += switch ($line) {
        "A X" { 4 } # Rock Rock
        "A Y" { 8 } # Rock Paper
        "A Z" { 3 } # Rock Scissors
        "B X" { 1 } # Paper Rock
        "B Y" { 5 } # Paper Paper
        "B Z" { 9 } # Paper Scissors
        "C X" { 7 } # Scissors Rock
        "C Y" { 2 } # Scissors Paper
        "C Z" { 6 } # Scissors Scissors
    }
}

Write-Host "Part 1 Solution"
Write-Host "The final score in the tournament for the strategy guide is: ${finalScore} points."

```

Once I got to part 2, I had to modify this code, however, since the value of the paterns changed.

## Part 2

In part one, the values of the `switch` block were calculated based on parameters given in the puzzle. A represented the opponent choosing rock, B: paper, and C: scissors. In turn, X represented the player choosing rock, Y: paper, and Z: scissors. Each chosen shape had a point value associated with it (**1** point for rock, **2** for paper, and **3** for scissors). The outcomes of the match ups also had a set value (**0** for lose, **3** for draw, and **6** for win). These two point values summed gave you the point value for each pattern. In part 2, however, the second letter in the pattern was given a new meaning. X now meant the player needed to lose, Y: draw, and Z: win. The point values remained the same, but the values were shifted around to match the outcome and which shape was used to achieve it.

At this point, I created a function, `Measure-Score`, that took a single pattern as an input along with each part we were trying to solve. A `switch` block then decided between assigning two different arrays of the values based on which part we were trying to solve before finally passing the pattern to another `switch` block that then returned the value from the chosen array. At this point, I was able to simple have the `foreach` loop run to solve both parts simultaneously.

My friend [bgalliford](https://github.com/bgalliford) and I are participating in the challenge together this year, and he created a more efficient solution that groups the like patterns using a modifed `Get-Content` call: `$guide = Get-Content ./input.txt | Sort-Object -Descending | Group-Object`. By using `Sort-Object` to sort the values from the input file followed by `Group-Object` to group the like values, he could get counts for each patternt to multiply by that pattern's value in each part, then simply sum the pattern totals to get a final result, needing a `foreach` loop only to go through the nine patterns rather than every line from the input file. After I showed him my solution with the function, he "combined the powers" of our two solutions using my function and his more efficient point calculation. You can check out this solution at: [day02_captainPlanet.ps1](https://github.com/bgalliford/AdventOfCode/blob/main/2022/day02/day02_captainPlanet.ps1).