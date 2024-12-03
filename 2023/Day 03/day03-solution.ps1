# Solution for Advent of Code 2023 Day 03 Part 1
# Created 03 Dec 2023 by Jack Truckenmiller

# Part 1 Goal: Find the sum of part numbers in an engine schematic

# Input file contains single lines of periods (empty), numbers, and
# symbols (which indicate a nearby number is a part number).

using namespace System.Collections.Generic

# Get-Content gives us these lines from the file in an array
$schematic = Get-Content ./day03-input.txt

$enginePartSum = 0
$symbolsIndicesMatrix = [List[[List[int]]]]::new()
foreach ($line in $schematic) {
    $symbolsIndices = [List[int]]::new()
    $lineSymbols = $line.ToCharArray() | Where-Object {$_ -match "[^.]"} | Where-Object {$_ -match "\D"} | Get-Unique
    if ($lineSymbols) {
        $startIndex = 0
        while ($startIndex -ne -1) {
            $result = $line.IndexOfAny($lineSymbols, $startIndex)
            if ($result -eq -1) {
                $startIndex = $result
            }
            else {
                $symbolsIndices.Add($result)
                $startIndex = $result + 1
                if ($startIndex -ge $line.Length) {
                    break
                }
            }
        }
    }
    $symbolsIndicesMatrix.Add($symbolsIndices)
}
$digits = '1', '2', '3', '4', '5', '6', '7', '8', '9', '0'
for ($i = 0; $i -lt $schematic.Length; $i++) {
    $startIndex = 0
    $lineCharArray = $schematic[$i].ToCharArray()
    if ($i -eq 0) {
        while ($startIndex -ne -1) {
            $matchFound = $false
            $result = $schematic[0].IndexOfAny($digits, $startIndex)
            if ($result -eq -1) {
                $startIndex = $result
            }
            elseif ($result -eq 0) {
                for ($j = 0; $j -lt 2; $j++) {
                    foreach ($symbolIndex in $symbolsIndicesMatrix[$j]) {
                        for ($k = 0; $k -lt 2; $k++) {
                            if ($result + $k -eq $symbolIndex) {
                                $matchFound = $true
                                break
                            }
                        }
                        if ($matchFound) {
                            break
                        }
                    }
                    if ($matchFound) {
                        break
                    }
                }
                if ($matchFound) {
                    $digit = ""
                    $digit += $lineCharArray[0]
                    for ($j = 1; $j -lt $lineCharArray.Count; $j++) {
                        $startIndex++
                        if ($digits -contains $lineCharArray[$j]) {
                            $digit += $lineCharArray[$j]
                        }
                        else {
                            break
                        }
                    }
                    $enginePartSum += [int]$digit
                }
                else {
                    $startIndex++
                }
            }
            elseif ($result -eq $schematic[0].Length - 1) {
                for ($j = 0; $j -lt 2; $j++) {
                    foreach ($symbolIndex in $symbolsIndicesMatrix[$j]) {
                        for ($k = -1; $k -lt 1; $k++) {
                            if ($result + $k -eq $symbolIndex) {
                                $matchFound = $true
                                break
                            }
                        }
                        if ($matchFound) {
                            break
                        }
                    }
                    if ($matchFound) {
                        break
                    }
                }
                if ($matchFound) {
                    $digit = ""
                    $digit += $lineCharArray[0]
                    for ($j = $result - 1; $j -ge 0; $j--) {
                        if ($digits -contains $lineCharArray[$j]) {
                            $digit = $lineCharArray[$j] + $digit
                        }
                        else {
                            break
                        }
                    }
                    $enginePartSum += [int]$digit
                }
                $startIndex = -1
            }
            else {
                for ($j = 0; $j -lt 2; $j++) {
                    foreach ($symbolIndex in $symbolsIndicesMatrix[$j]) {
                        for ($k = -1; $k -lt 2; $k++) {
                            if ($result + $k -eq $symbolIndex) {
                                $matchFound = $true
                                break
                            }
                        }
                        if ($matchFound) {
                            break
                        }
                    }
                    if ($matchFound) {
                        break
                    }
                }
                $startIndex = $result
                if ($matchFound) {
                    $digit = ""
                    $digit += $lineCharArray[$result]
                    for ($j = $result - 1; $j -ge 0; $j--) {
                        if ($digits -contains $lineCharArray[$j]) {
                            $digit = $lineCharArray[$j] + $digit
                        }
                        else {
                            break
                        }
                    }
                    for ($j = $result + 1; $j -lt $lineCharArray.Count; $j++) {
                        $startIndex++
                        if ($digits -contains $lineCharArray[$j]) {
                            $digit += $lineCharArray[$j]
                        }
                        else {
                            break
                        }
                    }
                    $enginePartSum += [int]$digit
                }
                else {
                    $startIndex++
                }

                if ($startIndex -ge $schematic[0].Length) {
                    break
                }
            }
        }
    }
    elseif ($i -eq $schematic.Length - 1) {
        while ($startIndex -ne -1) {
            $matchFound = $false
            $result = $schematic[$i].IndexOfAny($digits, $startIndex)
            if ($result -eq -1) {
                $startIndex = $result
            }
            elseif ($result -eq 0) {
                for ($j = $i - 1; $j -lt $i + 1; $j++) {
                    foreach ($symbolIndex in $symbolsIndicesMatrix[$j]) {
                        for ($k = 0; $k -lt 2; $k++) {
                            if ($result + $k -eq $symbolIndex) {
                                $matchFound = $true
                                break
                            }
                        }
                        if ($matchFound) {
                            break
                        }
                    }
                    if ($matchFound) {
                        break
                    }
                }
                if ($matchFound) {
                    $digit = ""
                    $digit += $lineCharArray[0]
                    for ($j = 1; $j -lt $lineCharArray.Count; $j++) {
                        $startIndex++
                        if ($digits -contains $lineCharArray[$j]) {
                            $digit += $lineCharArray[$j]
                        }
                        else {
                            break
                        }
                    }
                    $enginePartSum += [int]$digit
                }
                else {
                    $startIndex++
                }
            }
            elseif ($result -eq $schematic[$i].Length - 1) {
                for ($j = $i - 1; $j -lt $i + 1; $j++) {
                    foreach ($symbolIndex in $symbolsIndicesMatrix[$j]) {
                        for ($k = -1; $k -lt 1; $k++) {
                            if ($result + $k -eq $symbolIndex) {
                                $matchFound = $true
                                break
                            }
                        }
                        if ($matchFound) {
                            break
                        }
                    }
                    if ($matchFound) {
                        break
                    }
                }
                if ($matchFound) {
                    $digit = ""
                    $digit += $lineCharArray[0]
                    for ($j = $result - 1; $j -ge 0; $j--) {
                        if ($digits -contains $lineCharArray[$j]) {
                            $digit = $lineCharArray[$j] + $digit
                        }
                        else {
                            break
                        }
                    }
                    $enginePartSum += [int]$digit
                }
                $startIndex = -1
            }
            else {
                for ($j = $i - 1; $j -lt $i + 1; $j++) {
                    foreach ($symbolIndex in $symbolsIndicesMatrix[$j]) {
                        for ($k = -1; $k -lt 2; $k++) {
                            if ($result + $k -eq $symbolIndex) {
                                $matchFound = $true
                                break
                            }
                        }
                        if ($matchFound) {
                            break
                        }
                    }
                    if ($matchFound) {
                        break
                    }
                }
                $startIndex = $result
                if ($matchFound) {
                    $digit = ""
                    $digit += $lineCharArray[$result]
                    for ($j = $result - 1; $j -ge 0; $j--) {
                        if ($digits -contains $lineCharArray[$j]) {
                            $digit = $lineCharArray[$j] + $digit
                        }
                        else {
                            break
                        }
                    }
                    for ($j = $result + 1; $j -lt $lineCharArray.Count; $j++) {
                        $startIndex++
                        if ($digits -contains $lineCharArray[$j]) {
                            $digit += $lineCharArray[$j]
                        }
                        else {
                            break
                        }
                    }
                    $enginePartSum += [int]$digit
                }
                else {
                    $startIndex++
                }

                if ($startIndex -ge $schematic[$i].Length) {
                    break
                }
            }
        }
    }
    else {
        while ($startIndex -ne -1) {
            $matchFound = $false
            $result = $schematic[$i].IndexOfAny($digits, $startIndex)
            if ($result -eq -1) {
                $startIndex = $result
            }
            elseif ($result -eq 0) {
                for ($j = $i - 1; $j -lt $i + 2; $j++) {
                    foreach ($symbolIndex in $symbolsIndicesMatrix[$j]) {
                        for ($k = 0; $k -lt 2; $k++) {
                            if ($result + $k -eq $symbolIndex) {
                                $matchFound = $true
                                break
                            }
                        }
                        if ($matchFound) {
                            break
                        }
                    }
                    if ($matchFound) {
                        break
                    }
                }
                if ($matchFound) {
                    $digit = ""
                    $digit += $lineCharArray[0]
                    for ($j = 1; $j -lt $lineCharArray.Count; $j++) {
                        $startIndex++
                        if ($digits -contains $lineCharArray[$j]) {
                            $digit += $lineCharArray[$j]
                        }
                        else {
                            break
                        }
                    }
                    $enginePartSum += [int]$digit
                }
                else {
                    $startIndex++
                }
            }
            elseif ($result -eq $schematic[$i].Length - 1) {
                for ($j = $i - 1; $j -lt $i + 2; $j++) {
                    foreach ($symbolIndex in $symbolsIndicesMatrix[$j]) {
                        for ($k = -1; $k -lt 1; $k++) {
                            if ($result + $k -eq $symbolIndex) {
                                $matchFound = $true
                                break
                            }
                        }
                        if ($matchFound) {
                            break
                        }
                    }
                    if ($matchFound) {
                        break
                    }
                }
                if ($matchFound) {
                    $digit = ""
                    $digit += $lineCharArray[0]
                    for ($j = $result - 1; $j -ge 0; $j--) {
                        if ($digits -contains $lineCharArray[$j]) {
                            $digit = $lineCharArray[$j] + $digit
                        }
                        else {
                            break
                        }
                    }
                    $enginePartSum += [int]$digit
                }
                $startIndex = -1
            }
            else {
                for ($j = $i - 1; $j -lt $i + 2; $j++) {
                    foreach ($symbolIndex in $symbolsIndicesMatrix[$j]) {
                        for ($k = -1; $k -lt 2; $k++) {
                            if ($result + $k -eq $symbolIndex) {
                                $matchFound = $true
                                break
                            }
                        }
                        if ($matchFound) {
                            break
                        }
                    }
                    if ($matchFound) {
                        break
                    }
                }
                $startIndex = $result
                if ($matchFound) {
                    $digit = ""
                    $digit += $lineCharArray[$result]
                    for ($j = $result - 1; $j -ge 0; $j--) {
                        if ($digits -contains $lineCharArray[$j]) {
                            $digit = $lineCharArray[$j] + $digit
                        }
                        else {
                            break
                        }
                    }
                    for ($j = $result + 1; $j -lt $lineCharArray.Count; $j++) {
                        $startIndex++
                        if ($digits -contains $lineCharArray[$j]) {
                            $digit += $lineCharArray[$j]
                        }
                        else {
                            break
                        }
                    }
                    $enginePartSum += [int]$digit
                }
                else {
                    $startIndex++
                }

                if ($startIndex -ge $schematic[$i].Length) {
                    break
                }
            }
        }
    }
}

Write-Host "Part 1 Solution"
Write-Host "Sum of engine part numbers:" $enginePartSum
