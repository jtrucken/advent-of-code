# Solution for Advent of Code 2023 Day 01 Part 2
# Created 01 Dec 2023 by Jack Truckenmiller

# Part 2 Goal: Find the sum of calibration values for a trebuchet
# with input now including both digits and words representing digits

# Input file contains single lines of strings containing the
# calibration values for the trebuchet

# Get-Content gives us these lines from the file in an array
$calibrationValues = Get-Content ./day01-input.txt

# $wordDigits = @{
#     "one" = 1; 
#     "two" = 2; 
#     "three" = 3; 
#     "four" = 4; 
#     "five" = 5; 
#     "six" = 6; 
#     "seven" = 7; 
#     "eight" = 8; 
#     "nine" = 9
# }

# $calibrationValueSum = 0
# foreach ($calibrationValue in $calibrationValues) {
#     Write-Host $calibrationValue
#     $parsedValues = @()
#     foreach ($word in $wordDigits.Keys) {
#         if ($calibrationValue.Contains($word)) {
#             $parsedValues += $calibrationValue.Replace($word, $wordDigits[$word])
#         }
#     }
#     if ($parsedValues.Count -eq 0) {
#         $digits = $calibrationValue.ToCharArray() | Where-Object {$_ -match "\d"}
#         if ($digits.Count -eq 1) {
#             $value = $digits[0].ToString() + $digits[0].ToString()
#         }
#         else {
#             $value = $digits[0].ToString() + $digits[$digits.Count - 1].ToString()
#         }
#         Write-Host $value
#         $calibrationValueSum = $calibrationValueSum + [int]$value
#     }
#     else {
#         $firstDigits = @{}
#         $secondDigits = @{}
#         foreach ($parsedValue in $parsedValues) {
#             $digits = $parsedValue.ToCharArray() | Where-Object {$_ -match "\d"}
#             if ($firstDigits.Keys -contains $digits[0]) {
#                 if ($firstDigits[$digits[0]] -gt $parsedValue.IndexOf($digits[0])) {
#                     $firstDigits[$digits[0]] = $parsedValue.IndexOf($digits[0])
#                 }
#             }
#             else {
#                 $firstDigits.Add($digits[0], $parsedValue.IndexOf($digits[0]))
#             }
    
#             $lastIndex = $digits.Count - 1
#             if ($secondDigits.Keys -contains $digits[$lastIndex]) {
#                 if ($secondDigits[$digits[$lastIndex]] -lt $parsedValue.LastIndexOf($digits[$lastIndex])) {
#                     $secondDigits[$digits[$lastIndex]] = $parsedValue.LastIndexOf($digits[$lastIndex])
#                 }
#             }
#             else {
#                 $secondDigits.Add($digits[$lastIndex], $parsedValue.LastIndexOf($digits[$lastIndex]))
#             }
#         }
#         Write-Host $firstDigits
#         $firstDigit = $firstDigits.GetEnumerator() | Sort-Object -Property Value | Select-Object -First 1 -ExpandProperty Key
#         Write-Host $firstDigit
#         Write-Host $secondDigits
#         $secondDigit = $secondDigits.GetEnumerator() | Sort-Object -Property Value | Select-Object -Last 1 -ExpandProperty Key
#         Write-Host $secondDigit
#         $combinedDigit = $firstDigit.ToString() + $secondDigit.ToString()
#         Write-Host $combinedDigit
#         $calibrationValueSum = $calibrationValueSum + [int]$combinedDigit
#     }
# }

# Loop through each line and get the first and last digit present
# Combine the digits into a single number, then add them to the total
$calibrationValueSum = 0
foreach ($calibrationValue in $calibrationValues) {
    # Turns the string into an array of characters, then filters to an array
    # that has only numbers
    $linePt2 = $calibrationValue -Replace "one", "o1e" -Replace "two", "t2o" -Replace "three", "t3e" -Replace "four", "f4r" -Replace "five", "f5e" -Replace "six", "s6x" -Replace "seven", "s7n" -Replace "eight", "e8t" -Replace "nine", "n9e"
    $digits = $linePt2.ToCharArray() | Where-Object {$_ -match "\d"}
    if ($digits.Count -eq 1) {
        $value = $digits[0].ToString() + $digits[0].ToString()
    }
    else {
        $value = $digits[0].ToString() + $digits[$digits.Count - 1].ToString()
    }
    $calibrationValueSum = $calibrationValueSum + [int]$value
}

Write-Host "Part 2 Solution"
Write-Host "Sum of trebuchet calibration values:" $calibrationValueSum