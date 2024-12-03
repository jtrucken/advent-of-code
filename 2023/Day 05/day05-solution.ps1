# Solution for Advent of Code 2023 Day 05
# Created 05 Dec 2023 by Jack Truckenmiller

# Part 1 Goal: Find the closest seed location after mapping
# seed values through translation ranges
# Part 2 Goal: ???

# Input file contains seed values as well as lines of text
# describing lines of numbers that follow which represent
# ranges used to map the seed values to another integer

using namespace System.Collections.Generic

# Get-Content gives us these lines from the file in an array
$almanac = Get-Content ./day05-input.txt

$seedValues = [Queue[Int64]]::new()
foreach ($line in $almanac) {
    if ($line.IndexOf("seeds: ") -ne -1) {
        $discard, $seeds = $line -split ": "
        $seedNumbers = $seeds -split "\s" | Where-Object {$_ -match "\d"}
        foreach ($seedNumber in $seedNumbers) {
            $seedValues.Enqueue([int64]$seedNumber)
        }
    }
    elseif ([string]::IsNullOrWhiteSpace($line)) {
        continue
    }
    elseif ($line[0] -match "\d") {
        $mapValues = $line -split "\s"
        $destination = [int64]$mapValues[0]
        $source = [int64]$mapValues[1]
        $range = [int64]$mapValues[2]
        $seedValue = $seedValues.Dequeue()
        if ($seedValue -lt $source -or $seedValue -gt ($source + ($range))) {
            $seedValues.Enqueue($seedValue)
        }
        elseif ($seedValue -eq $source) {
            $seedValues.Enqueue($destination)
        }
        elseif ($seedValue -eq ($source + ($range))) {
            $seedValues.Enqueue(($destination + ($range)))
        }
        else {
            $valueDiff = $seedValue - $source
            $seedValues.Enqueue(($destination + $valueDiff))
        }
    }
}
$finalValues = $seedValues.ToArray()
Write-Host $finalValues
$lowestValue = $finalValues | Sort-Object | Select-Object -First 1
Write-Host "Part 1 Solution"
Write-Host "Closest seed location:" $lowestValue
