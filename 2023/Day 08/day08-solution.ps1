# Solution for Advent of Code 2023 Day 08
# Created 08 Dec 2023 by Jack Truckenmiller

# Part 1 Goal: Navigate a network from point AAA to 
# point ZZZ
# Part 2 Goal: Simultaneously navigate a network from
# all points ending in A until all resulting points
# end in Z

# Input file contains left/right instructions on the
# first line, a space, and then the instructions
# mapping a value to a pair of left/right values

using namespace System
using namespace System.Collections.Generic

function Get-Point {
    param (
        [Parameter(Mandatory, Position = 0)]
        [string]$InputPoint,

        [Parameter(Mandatory, Position = 1)]
        [char]$InputInst,

        [Parameter(Mandatory, Position = 2)]
        [hashtable]$InputMap
    )

    if ($InputInst -eq 'L') {
        return $InputMap[$InputPoint].Item1
    }
    else {
        return $InputMap[$InputPoint].Item2
    }
}

# Get-Content gives us these lines from the file in an array
$directions = Get-Content ./day08-input.txt

$instructions = [Queue[char]]::new()
$instructions2 = [Queue[char]]::new()
$line1 = $directions[0].ToCharArray()
foreach ($item in $line1) {
    $instructions.Enqueue($item)
    $instructions2.Enqueue($item)
}

$mappings = @{}
for ($i = 2; $i -lt $directions.Length; $i++) {
    $line = $directions[$i]
    $leftValue, $rightValues = $line -split " = "
    $rightValue1, $rightValue2 = $rightValues -split ", "
    $rightTuple = [Tuple]::Create($rightValue1.Substring(1), $rightValue2.Substring(0,3))
    $mappings[$leftValue] = $rightTuple
}

$currentPoint = "AAA"
$numberOfSteps = 0
while ($instructions.Count -gt 0) {
    $instruction = $instructions.Dequeue()
    $numberOfSteps++
    $currentPoint = Get-Point $currentPoint $instruction $mappings
    if ($currentPoint -eq "ZZZ") {
        break
    }
    $instructions.Enqueue($instruction)
}

Write-Host "Part 1 Solution"
Write-Host "Number of steps to reach ZZZ:" $numberOfSteps

$currentPoints = $mappings.Keys | Where-Object {$_.LastIndexOf('A') -eq 2}
# $targetCount = $currentPoints.Count
# $numberOfSteps = 0
# while ($instructions2.Count -gt 0) {
#     $instruction = $instructions2.Dequeue()
#     $numberOfSteps++
#     $newPoints = @()
#     foreach ($currentPoint in $currentPoints) {
#         $newPoints += Get-Point $currentPoint $instruction $mappings
#     }
#     $endsInZ = $newPoints | Where-Object {$_.LastIndexOf('Z') -eq 2}
#     if ($endsInZ) {
#         Write-Host $endsInZ
#     }
#     if ($endsInZ.Count -eq $targetCount) {
#         break
#     }
#     else {
#         $currentPoints = $newPoints
#     }
#     $instructions2.Enqueue($instruction)
# }
$numberOfStepsArr = @()
foreach ($currentPoint in $currentPoints) {
    $instructions = $instructions2
    $numberOfSteps = 0
    while ($instructions.Count -gt 0) {
        $instruction = $instructions.Dequeue()
        $numberOfSteps++
        $currentPoint = Get-Point $currentPoint $instruction $mappings
        if ($currentPoint.LastIndexOf('Z') -eq 2) {
            $numberOfStepsArr += $numberOfSteps
            break
        }
        $instructions.Enqueue($instruction)
    }
}
$lcmFound = $false
$i = $numberOfStepsArr | Sort-Object | Select-Object -Last 1
$j = 1
while (!$lcmFound) {
    $i *= $j
    $divisionResults = @()
    foreach ($numberOfSteps in $numberOfStepsArr) {
        $divisionResults += $i % $numberOfSteps
    }
    $allZeroes = $divisionResults | Where-Object {$_ -eq 0}
    $lcmFound = $allZeroes.Count -eq $divisionResults.Count
}

Write-Host "Part 2 Solution"
Write-Host "Number of steps to reach all points ending in Z:" $i