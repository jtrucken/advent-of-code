# Solution for Advent of Code 2023 Day 01 Part 1
# Created 01 Dec 2023 by Jack Truckenmiller

# Part 1 Goal: Find the sum of calibration values for a trebuchet

# Input file contains single lines of strings containing the
# calibration values for the trebuchet

# Get-Content gives us these lines from the file in an array
$calibrationValues = Get-Content ./day01-input.txt

# Loop through each line and get the first and last digit present
# Combine the digits into a single number, then add them to the total
$calibrationValueSum = 0
foreach ($calibrationValue in $calibrationValues) {
    # Turns the string into an array of characters, then filters to an array
    # that has only numbers
    $digits = $calibrationValue.ToCharArray() | Where-Object {$_ -match "\d"}
    if ($digits.Count -eq 1) {
        $value = $digits[0].ToString() + $digits[0].ToString()
    }
    else {
        $value = $digits[0].ToString() + $digits[$digits.Count - 1].ToString()
    }
    $calibrationValueSum = $calibrationValueSum + [int]$value
}
Write-Host "Part 1 Solution"
Write-Host "Sum of trebuchet calibration values:" $calibrationValueSum