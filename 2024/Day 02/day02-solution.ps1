# Solution for Advent of Code 2024 Day 02
# Created 02 Dec 2024 by Jack Truckenmiller

# Part 1 Goal: Find the how many reports are safe

# Input file contains single lines of increasing and
# decreasing numbers representing the levels of a reactor

# Get-Content gives us these lines from the file in an array
$reports = Get-Content ./day02-input.txt

$safeReports = 0
foreach ($report in $reports) {
    $reportArr = $report -split ' '
    $safe = $true
    for ($i = 0; $i -lt $reportArr.Length - 1; $i++) {
        $difference = $reportArr[$i + 1] - $reportArr[$i]
        if ([Math]::Abs($difference) -lt 1 -or [Math]::Abs($difference) -gt 3) {
            # Unsafe, break the loop
            $safe = $false
            break
        }
        if ($i -eq 0) {
            $prevResult = $difference
        }
        else {
            if (($prevResult -gt 0 -and $difference -lt 0) -or ($prevResult -lt 0 -and $difference -gt 0)) {
                # Unsafe, break the loop
                $safe = $false
                break
            }
            $prevResult = $difference
        }
    }
    if ($safe) {
        $safeReports++
    }
}
Write-Host "The number of safe reports is: " $safeReports

# Part 2 Goal: Same as before, but we can now tolerate one bad level
$safeReportsMod = 0
foreach ($report in $reports) {
    $reportArr = $report -split ' '
    $safe = $true
    $dampened = $true
    for ($i = 0; $i -lt $reportArr.Length - 1; $i++) {
        $difference = $reportArr[$i + 1] - $reportArr[$i]
        if ([Math]::Abs($difference) -lt 1 -or [Math]::Abs($difference) -gt 3) {
            if ($dampened) {
                $dampened = $false
                if ($i -eq 0) {
                    $difference = $reportArr[$i + 2] - $reportArr[$i + 1]
                }
                else {
                    $difference = $reportArr[$i + 1] - $reportArr[$i - 1]
                }
                if ($i -gt 1) {
                    $prevResult = $reportArr[$i - 1] - $reportArr[$i - 2]
                }
                elseif ($i -eq 1) {
                    $prevResult = $difference
                }
            } else {
                # Unsafe, break the loop
                $safe = $false
                break
            }
        }
        if ($i -eq 0) {
            if ($dampened) {
                $prevResult = $difference
            }
            else {
                $prevResult = $reportArr[2] - $reportArr[1]
            }
        }
        else {
            if (($prevResult -gt 0 -and $difference -lt 0) -or ($prevResult -lt 0 -and $difference -gt 0)) {
                if ($dampened) {
                    $dampened = $false
                    $difference = $reportArr[$i + 1] - $reportArr[$i - 1]
                    if ($i -eq 1) {
                        $prevResult = $difference
                    }
                    else {
                        $prevResult = $reportArr[$i - 1] - $reportArr[$i - 2]
                    }
                    if (($prevResult -gt 0 -and $difference -lt 0) -or ($prevResult -lt 0 -and $difference -gt 0)) {
                        # Unsafe, break the loop
                        $safe = $false
                        break
                    }
                } 
                else {
                    # Unsafe, break the loop
                    $safe = $false
                    break
                }
            }
            $prevResult = $difference
        }
    }
    if ($safe) {
        $safeReportsMod++
    }
}
Write-Host "The modified number of safe reports is: " $safeReportsMod