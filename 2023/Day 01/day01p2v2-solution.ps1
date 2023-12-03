# Solution for Advent of Code 2023 Day 01 Part 2
# Created 01 Dec 2023 by Jack Truckenmiller

# Part 2 Goal: Find the sum of calibration values for a trebuchet
# with input now including both digits and words representing digits

# Input file contains single lines of strings containing the
# calibration values for the trebuchet

# Get-Content gives us these lines from the file in an array
$calibrationValues = Get-Content ./day01-input.txt

$firstChars = 'o', 't', 'f', 's', 'e', 'n'
$lastChars = 'e', 'o', 'r', 'x', 'n', 't'

# Loop through each line and get the first and last digit present
# Combine the digits into a single number, then add them to the total
$calibrationValueSum = 0
foreach ($calibrationValue in $calibrationValues) {
    $chars = $calibrationValue.ToCharArray()
    $potentialDigit = ""
    $firstDigit = ''
    $secondDigit = ''
    # This is a doozy, but the gist is that we're matching on characters 
    # in the array to either find the first digit in number or word form.
    # Numbers are easy, but the words require building out smaller strings
    # to see if they match any of digits one through nine. After we do it
    # forward, we have to do it in reverse to find the last digit.
    foreach ($character in $chars) {
        if ($character -match "\d") {
            $firstDigit = $character
        }
        elseif ([string]::IsNullOrWhiteSpace($potentialDigit) -and $firstChars -contains $character) {
            $potentialDigit = $potentialDigit + $character
        }
        elseif ($potentialDigit) {
            # 'o', 't', 'f', 's', 'e', 'n'
            switch ($potentialDigit) {
                "o" { 
                    if ($character -eq 'n') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "on" {
                    if ($character -eq 'e') {
                        $firstDigit = '1'
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "t" { 
                    if ($character -eq 'w' -or $character -eq 'h') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "tw" { 
                    if ($character -eq 'o') {
                        $firstDigit = '2'
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "th" { 
                    if ($character -eq 'r') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "thr" { 
                    if ($character -eq 'e') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "thre" { 
                    if ($character -eq 'e') {
                        $firstDigit = '3'
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "f" { 
                    if ($character -eq 'o' -or $character -eq 'i') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "fo" { 
                    if ($character -eq 'u') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "fou" { 
                    if ($character -eq 'r') {
                        $firstDigit = '4'
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "fi" { 
                    if ($character -eq 'v') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "fiv" { 
                    if ($character -eq 'e') {
                        $firstDigit = '5'
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "s" { 
                    if ($character -eq 'i' -or $character -eq 'e') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "si" { 
                    if ($character -eq 'x') {
                        $firstDigit = '6'
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "se" { 
                    if ($character -eq 'v') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "sev" { 
                    if ($character -eq 'e') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "seve" { 
                    if ($character -eq 'n') {
                        $firstDigit = '7'
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "e" {
                    if ($character -eq 'i') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "ei" {
                    if ($character -eq 'g') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "eig" {
                    if ($character -eq 'h') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "eigh" {
                    if ($character -eq 't') {
                        $firstDigit = '8'
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "n" {
                    if ($character -eq 'i') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "ni" {
                    if ($character -eq 'n') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "nin" {
                    if ($character -eq 'e') {
                        $firstDigit = '9'
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                Default {}
            }

        }
        if ($firstDigit) {
            $potentialDigit = ""
            break
        } 
    }
    $backwardsChars = $calibrationValue.ToCharArray()
    [array]::Reverse($backwardsChars)
    foreach ($character in $backwardsChars) {
        if ($character -match "\d") {
            $secondDigit = $character
        }
        elseif ([string]::IsNullOrWhiteSpace($potentialDigit) -and $lastChars -contains $character) {
            $potentialDigit = $character.ToString()
        }
        elseif ($potentialDigit) {
            # 'e', 'o', 'r', 'x', 'n', 't'
            switch ($potentialDigit) {
                "e" { 
                    if ($character -eq 'n' -or $character -eq 'e' -or $character -eq 'v') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($lastChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "en" {
                    if ($character -eq 'o') {
                        $secondDigit = '1'
                    }
                    elseif ($character -eq 'i') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($lastChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "eni" {
                    if ($character -eq 'n') {
                        $secondDigit = '9'
                    }
                    elseif ($lastChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "ee" { 
                    if ($character -eq 'r') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($lastChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "eer" { 
                    if ($character -eq 'h') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($lastChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "eerh" { 
                    if ($character -eq 't') {
                        $secondDigit = '3'
                    }
                    elseif ($lastChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "ev" { 
                    if ($character -eq 'i') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($lastChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "evi" { 
                    if ($character -eq 'f') {
                        $secondDigit = '5'
                    }
                    elseif ($lastChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "o" { 
                    if ($character -eq 'w') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($lastChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "ow" { 
                    if ($character -eq 't') {
                        $secondDigit = '2'
                    }
                    elseif ($lastChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "r" {
                    if ($character -eq 'u') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($lastChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "ru" {
                    if ($character -eq 'o') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($lastChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "ruo" {
                    if ($character -eq 'f') {
                        $secondDigit = '4'
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "x" { 
                    if ($character -eq 'i') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($lastChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "xi" { 
                    if ($character -eq 's') {
                        $secondDigit = '6'
                    }
                    elseif ($lastChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "n" {
                    if ($character -eq 'e') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($lastChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "ne" {
                    if ($character -eq 'v') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($character -eq 'n') {
                        $potentialDigit = "en"
                    }
                    elseif ($lastChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "nev" { 
                    if ($character -eq 'e') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($character -eq 'i') {
                        $potentialDigit = "evi"
                    }
                    elseif ($firstChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "neve" { 
                    if ($character -eq 's') {
                        $secondDigit = '7'
                    }
                    elseif ($lastChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "t" { 
                    if ($character -eq 'h') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($lastChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "th" { 
                    if ($character -eq 'g') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($lastChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "thg" { 
                    if ($character -eq 'i') {
                        $potentialDigit = $potentialDigit + $character
                    }
                    elseif ($lastChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                "thgi" {
                    if ($character -eq 'e') {
                        $secondDigit = '8'
                    }
                    elseif ($lastChars -contains $character) {
                        $potentialDigit = $character.ToString()
                    }
                    else {
                        $potentialDigit = ""
                    }
                }
                Default {}
            }
        }
        if ($secondDigit) {
            break
        } 
    }
    $value = $firstDigit + $secondDigit
    Write-Host $value
    $calibrationValueSum = $calibrationValueSum + [int]$value
}

Write-Host "Part 2 Solution"
Write-Host "Sum of trebuchet calibration values:" $calibrationValueSum