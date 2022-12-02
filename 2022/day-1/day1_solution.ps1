# Solution for Advent of Code 2022 Day 1
# Created 1 Dec 2022 by Jack Truckenmiller

#Part 1 Goal: Find the highest total calories carried by an elf
#Part 2 Goal: Find the total calories of the three highest total calories summed

# Input file contains single lines of numbers, representing calorie totals carried by elves
# and blank lines to divide groups of numbers which represents the different bags of the elves

# Get-Content gives us these lines from the file in an array
$rawCalories = Get-Content ./Inputs/input.txt

# The foreach loop goes through each line, summing calorie values until a blank line is found,
# then the value is added to the total list, and the storage variable for the sum is reset
$currentCaloriesSum = 0
$totalCaloriesList = [System.Collections.Generic.List[int]]::new()
foreach ($line in $rawCalories) {
    if ([string]::IsNullOrWhiteSpace($line)) {
        $totalCaloriesList.Add($currentCaloriesSum)
        $currentCaloriesSum = 0
    }
    else {
        $currentCaloriesSum += [int]$line.Trim()
    }
}

# Sorts the list value descending, so we can retrieve the highest total calories
# This solves part 1
$sortedCaloriesList = [System.Collections.Generic.List[int]]::new()
$sortedCaloriesList = $totalCaloriesList | Sort-Object -Descending
$highestAmount = $sortedCaloriesList[0]
Write-Host "Part 1's Solution"
Write-Host "The highest calorie amount carried is $highestAmount calories."
Write-Host ""

# Since the list is already sorted, just add the next two values to it to solve part 2
$top3CaloriesSum = $sortedCaloriesList[0] + $sortedCaloriesList[1] + $sortedCaloriesList[2]
Write-Host "Part 2's Solution"
Write-Host "The sum of the top 3 calorie amounts carred is $top3CaloriesSum calories."