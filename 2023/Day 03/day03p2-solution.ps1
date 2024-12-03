# Solution for Advent of Code 2023 Day 03 Part 2
# Created 03 Dec 2023 by Jack Truckenmiller

# Part 2 Goal: Find the sum of gear ratios (multiple of exactly two
# numbers around an *)

# Input file contains single lines of periods (empty), numbers, and
# symbols (which indicate a nearby number is a part number).

using namespace System.Collections.Generic

# Get-Content gives us these lines from the file in an array
$schematic = Get-Content ./day03-input.txt

function Join-Digits {
    param (
        [Parameter(Mandatory)]
        [array]$DigitAndIndex,

        [Parameter(Mandatory)]
        [string]$LineToSearch
    )

    $lineCharArray = $LineToSearch.ToCharArray()
    $digit = $DigitAndIndex[0]
    for ($j = $DigitAndIndex[1] - 1; $j -ge 0; $j--) {
        if ($lineCharArray[$j] -match "\d") {
            $digit = $lineCharArray[$j] + $digit
        }
        else {
            break
        }
    }
    for ($j = $DigitAndIndex[1] + 1; $j -lt $lineCharArray.Count; $j++) {
        if ($lineCharArray[$j] -match "\d") {
            $digit += $lineCharArray[$j]
        }
        else {
            break
        }
    }
    return [int]$digit
}

$gearRatioSum = 0
for ($i = 0; $i -lt $schematic.Length; $i++) { 
    if ($schematic[$i] -contains "[^*]") {
        continue
    }

    $startIndex = 0
    $lineCharArray = $schematic[$i].ToCharArray()
    if ($i -eq 0) {
        while ($startIndex -ne -1) {
            $numberOfNumbers = 0
            $lastCharacterWasNumber = $false
            $digits = [List[int]]::new()
            $result = $schematic[0].IndexOf('*', $startIndex)
            if ($result -eq -1) {
                $startIndex = $result
            }
            elseif ($result -eq 0) {
                for ($j = 0; $j -lt 2; $j++) {
                    for ($k = 0; $k -lt 2; $k++) {
                        $character = $schematic[$j].Substring($result + $k, 1)
                        if ($character -match "\d") {
                            if (!$lastCharacterWasNumber) {
                                $funcStart = $result + $k
                                $digit = Join-Digits -DigitAndIndex @($character, $funcStart) -LineToSearch $schematic[$j]
                                $digits.Add($digit)
                                $numberOfNumbers++
                                $lastCharacterWasNumber = $true
                            }
                        }
                        else {
                            $lastCharacterWasNumber = $false
                        }
                    }
                    $lastCharacterWasNumber = $false
                }
                if ($numberOfNumbers -eq 2) {
                    $gearRatioSum += $digits[0] * $digits[1]
                }
                $startIndex++
            }
            elseif ($result -eq $schematic[0].Length - 1) {
                for ($j = 0; $j -lt 2; $j++) {
                    for ($k = -1; $k -lt 1; $k++) {
                        $character = $schematic[$j].Substring($result + $k, 1)
                        if ($character -match "\d") {
                            if (!$lastCharacterWasNumber) {
                                $funcStart = $result + $k
                                $digit = Join-Digits -DigitAndIndex @($character, $funcStart) -LineToSearch $schematic[$j]
                                $digits.Add($digit)
                                $numberOfNumbers++
                                $lastCharacterWasNumber = $true
                            }
                        }
                        else {
                            $lastCharacterWasNumber = $false
                        }
                    }
                    $lastCharacterWasNumber = $false
                }
                if ($numberOfNumbers -eq 2) {
                    $gearRatioSum += $digits[0] * $digits[1]
                }
                $startIndex = -1
            }
            else {
                for ($j = 0; $j -lt 2; $j++) {
                    for ($k = -1; $k -lt 2; $k++) {
                        $character = $schematic[$j].Substring($result + $k, 1)
                        if ($character -match "\d") {
                            if (!$lastCharacterWasNumber) {
                                $funcStart = $result + $k
                                $digit = Join-Digits -DigitAndIndex @($character, $funcStart) -LineToSearch $schematic[$j]
                                $digits.Add($digit)
                                $numberOfNumbers++
                                $lastCharacterWasNumber = $true
                            }
                        }
                        else {
                            $lastCharacterWasNumber = $false
                        }
                    }
                    $lastCharacterWasNumber = $false
                }
                $startIndex = $result + 1
                if ($numberOfNumbers -eq 2) {
                    $gearRatioSum += $digits[0] * $digits[1]
                }

                if ($startIndex -ge $schematic[0].Length) {
                    break
                }
            }
        }
    }
    elseif ($i -eq $schematic.Length - 1) {
        while ($startIndex -ne -1) {
            $numberOfNumbers = 0
            $lastCharacterWasNumber = $false
            $digits = [List[int]]::new()
            $result = $schematic[$i].IndexOf('*', $startIndex)
            if ($result -eq -1) {
                $startIndex = $result
            }
            elseif ($result -eq 0) {
                for ($j = $i - 1; $j -lt $i + 1; $j++) {
                    for ($k = 0; $k -lt 2; $k++) {
                        $character = $schematic[$j].Substring($result + $k, 1)
                        if ($character -match "\d") {
                            if (!$lastCharacterWasNumber) {
                                $funcStart = $result + $k
                                $digit = Join-Digits -DigitAndIndex @($character, $funcStart) -LineToSearch $schematic[$j]
                                $digits.Add($digit)
                                $numberOfNumbers++
                                $lastCharacterWasNumber = $true
                            }
                        }
                        else {
                            $lastCharacterWasNumber = $false
                        }
                    }
                    $lastCharacterWasNumber = $false
                }
                if ($numberOfNumbers -eq 2) {
                    $gearRatioSum += $digits[0] * $digits[1]
                }
                $startIndex++
            }
            elseif ($result -eq $schematic[$i].Length - 1) {
                for ($j = $i - 1; $j -lt $i + 1; $j++) {
                    for ($k = -1; $k -lt 1; $k++) {
                        $character = $schematic[$j].Substring($result + $k, 1)
                        if ($character -match "\d") {
                            if (!$lastCharacterWasNumber) {
                                $funcStart = $result + $k
                                $digit = Join-Digits -DigitAndIndex @($character, $funcStart) -LineToSearch $schematic[$j]
                                $digits.Add($digit)
                                $numberOfNumbers++
                                $lastCharacterWasNumber = $true
                            }
                        }
                        else {
                            $lastCharacterWasNumber = $false
                        }
                    }
                    $lastCharacterWasNumber = $false
                }
                if ($numberOfNumbers -eq 2) {
                    $gearRatioSum += $digits[0] * $digits[1]
                }
                $startIndex = -1
            }
            else {
                for ($j = $i - 1; $j -lt $i + 1; $j++) {
                    for ($k = -1; $k -lt 2; $k++) {
                        $character = $schematic[$j].Substring($result + $k, 1)
                        if ($character -match "\d") {
                            if (!$lastCharacterWasNumber) {
                                $funcStart = $result + $k
                                $digit = Join-Digits -DigitAndIndex @($character, $funcStart) -LineToSearch $schematic[$j]
                                $digits.Add($digit)
                                $numberOfNumbers++
                                $lastCharacterWasNumber = $true
                            }
                        }
                        else {
                            $lastCharacterWasNumber = $false
                        }
                    }
                    $lastCharacterWasNumber = $false
                }
                $startIndex = $result + 1
                if ($numberOfNumbers -eq 2) {
                    $gearRatioSum += $digits[0] * $digits[1]
                }

                if ($startIndex -ge $schematic[$i].Length) {
                    break
                }
            }
        }
    }
    else {
        while ($startIndex -ne -1) {
            $numberOfNumbers = 0
            $lastCharacterWasNumber = $false
            $digits = [List[int]]::new()
            $result = $schematic[$i].IndexOf('*', $startIndex)
            if ($result -eq -1) {
                $startIndex = $result
            }
            elseif ($result -eq 0) {
                for ($j = $i - 1; $j -lt $i + 2; $j++) {
                    for ($k = 0; $k -lt 2; $k++) {
                        $character = $schematic[$j].Substring($result + $k, 1)
                        if ($character -match "\d") {
                            if (!$lastCharacterWasNumber) {
                                $funcStart = $result + $k
                                $digit = Join-Digits -DigitAndIndex @($character, $funcStart) -LineToSearch $schematic[$j]
                                $digits.Add($digit)
                                $numberOfNumbers++
                                $lastCharacterWasNumber = $true
                            }
                        }
                        else {
                            $lastCharacterWasNumber = $false
                        }
                    }
                    $lastCharacterWasNumber = $false
                }
                if ($numberOfNumbers -eq 2) {
                    $gearRatioSum += $digits[0] * $digits[1]
                }
                $startIndex++
            }
            elseif ($result -eq $schematic[$i].Length - 1) {
                for ($j = $i - 1; $j -lt $i + 2; $j++) {
                    for ($k = -1; $k -lt 1; $k++) {
                        $character = $schematic[$j].Substring($result + $k, 1)
                        if ($character -match "\d") {
                            if (!$lastCharacterWasNumber) {
                                $funcStart = $result + $k
                                $digit = Join-Digits -DigitAndIndex @($character, $funcStart) -LineToSearch $schematic[$j]
                                $digits.Add($digit)
                                $numberOfNumbers++
                                $lastCharacterWasNumber = $true
                            }
                        }
                        else {
                            $lastCharacterWasNumber = $false
                        }
                    }
                    $lastCharacterWasNumber = $false
                }
                if ($numberOfNumbers -eq 2) {
                    $gearRatioSum += $digits[0] * $digits[1]
                }
                $startIndex = -1
            }
            else {
                for ($j = $i - 1; $j -lt $i + 2; $j++) {
                    for ($k = -1; $k -lt 2; $k++) {
                        $character = $schematic[$j].Substring($result + $k, 1)
                        if ($character -match "\d") {
                            if (!$lastCharacterWasNumber) {
                                $funcStart = $result + $k
                                $digit = Join-Digits -DigitAndIndex @($character, $funcStart) -LineToSearch $schematic[$j]
                                $digits.Add($digit)
                                $numberOfNumbers++
                                $lastCharacterWasNumber = $true
                            }
                        }
                        else {
                            $lastCharacterWasNumber = $false
                        }
                    }
                    $lastCharacterWasNumber = $false
                }
                $startIndex = $result + 1
                if ($numberOfNumbers -eq 2) {
                    $gearRatioSum += $digits[0] * $digits[1]
                }

                if ($startIndex -ge $schematic[$i].Length) {
                    break
                }
            }
        }
    }
}

Write-Host "Part 2 Solution"
Write-Host "Sum of gear ratios:" $gearRatioSum