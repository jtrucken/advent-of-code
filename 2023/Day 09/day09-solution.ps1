# Solution for Advent of Code 2023 Day 09
# Created 09 Dec 2023 by Jack Truckenmiller

# Part 1 Goal: Find the sum of extrapolated values
# from lists of history values
# Part 2 Goal: Same as part 1 except finding the value
# at the start of the list rather than the end

# Input file contains lines of history values separated
# by spaces

function Get-ArrayValueDiffs {
    param (
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [int[]]$InputObject
    )
    if ($InputObject.Count -le 1) {
        return $InputObject
    }

    [int[]]$output = @()
    for ($i = 0; $i -lt $InputObject.Count - 1; $i++) {
        $output += $InputObject[$i + 1] - $InputObject[$i]
    }
    return $output
}

function Find-NextArrayValue {
    param (
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [int[]]$InputObject
    )
    if ($InputObject.Count -eq 1) {
        if ($InputObject[0] -eq 0) {
            return 0
        }
        else {
            throw "Find-NextArrayValue requires an integer array with at least two elements if the elements are not 0."
        }
    }

    $zeroes = $InputObject | Where-Object { $_ -eq 0 }
    if ($InputObject.Count -eq $zeroes.Count) {
        return 0
    }
    else {
        $newArr = Get-ArrayValueDiffs $InputObject
        $diff = Find-NextArrayValue $newArr
        return $InputObject[-1] + $diff
    }
}

function Find-PrevArrayValue {
    param (
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [int[]]$InputObject
    )
    if ($InputObject.Count -eq 1) {
        if ($InputObject[0] -eq 0) {
            return 0
        }
        else {
            throw "Find-NextArrayValue requires an integer array with at least two elements if the elements are not 0."
        }
    }

    $zeroes = $InputObject | Where-Object { $_ -eq 0 }
    if ($InputObject.Count -eq $zeroes.Count) {
        return 0
    }
    else {
        $newArr = Get-ArrayValueDiffs $InputObject
        $diff = Find-PrevArrayValue $newArr
        return $InputObject[0] - $diff
    }
}

# Get-Content gives us these lines from the file in an array
$histories = Get-Content ./day09-input.txt

$newValuesSum = 0
$newValuesSum2 = 0
foreach ($historyLine in $histories) {
    $histArr = $historyLine -split "\s+"
    [int[]]$histInt = @()
    foreach ($hist in $histArr) {
        $histInt += [int]$hist
    }
    $newValuesSum += Find-NextArrayValue -InputObject $histInt
    $newValuesSum2 += Find-PrevArrayValue $histInt
}

Write-Host "Part 1 Solution"
Write-Host "Sum of extrapolated values:" $newValuesSum
Write-Host "Part 2 Solution"
Write-Host "Sum of extrapolated values:" $newValuesSum2