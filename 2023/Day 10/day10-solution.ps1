# Solution for Advent of Code 2023 Day 10
# Created 10 Dec 2023 by Jack Truckenmiller

# Part 1 Goal: Find the farthest point in a loop of pipes
# Part 2 Goal: Find the area of tiles contained within the
# loop

# Input file contains symbols representing pipes

using namespace System

# Get-Content gives us these lines from the file in an array
$pipesSketch = Get-Content ./day10-input.txt

for ($i = 0; $i -lt $pipesSketch.Length; $i++) {
    $sIndex = $pipesSketch[$i].IndexOf('S')
    if ($sIndex -ne -1) {
        $startCoord = [Tuple]::Create($i, $sIndex)
        break
    }
}

$pipeDir = @{
    '|' = [Tuple]::Create(1, 0);
    '-' = [Tuple]::Create(0, 1);
    'L' = [Tuple]::Create(1, 1);
    'J' = [Tuple]::Create(1, -1);
    '7' = [Tuple]::Create(-1, -1);
    'F' = [Tuple]::Create(-1, 1);
    'S' = [Tuple]::Create(0, 0)
}

$validStartingMoves = @()
for ($i = -1; $i -le 1; $i++) {
    $vertIdx = $startCoord.Item1 + $i
    if ($vertIdx -lt 0 -or $vertIdx -ge $pipesSketch.Length) {
        continue
    }
    for ($j = -1; $j -le 1; $j++) {
        $horizontalIdx = $startCoord.Item2 + $j
        if ($horizontalIdx -lt 0 -or $horizontalIdx -ge $pipesSketch[$vertIdx].Length) {
            continue
        }
        
        if ($i -eq $j) {
            # Diagonals aren't possible
            continue
        }
        elseif ($i -eq -1 -and $j -eq 0) {
            switch ($pipesSketch[$vertIdx][$horizontalIdx]) {
                '|' {
                    $validStartingMoves += [Tuple]::Create(-1, 0)
                }
                '7' {
                    $validStartingMoves += [Tuple]::Create(-1, 0)
                }
                'F' {
                    $validStartingMoves += [Tuple]::Create(-1, 0)
                }
            }
        }
        elseif ($i -eq 1 -and $j -eq 0) {
            switch ($pipesSketch[$vertIdx][$horizontalIdx]) {
                '|' {
                    $validStartingMoves += [Tuple]::Create(1, 0)
                }
                'L' {
                    $validStartingMoves += [Tuple]::Create(1, 0)
                }
                'J' {
                    $validStartingMoves += [Tuple]::Create(1, 0)
                }
            }
        }
        elseif ($i -eq 0 -and $j -eq -1) {
            switch ($pipesSketch[$vertIdx][$horizontalIdx]) {
                '-' {
                    $validStartingMoves += [Tuple]::Create(0, -1)
                }
                'L' {
                    $validStartingMoves += [Tuple]::Create(0, -1)
                }
                'F' {
                    $validStartingMoves += [Tuple]::Create(0, -1)
                }
            }
        }
        elseif ($i -eq 0 -and $j -eq 1) {
            switch ($pipesSketch[$vertIdx][$horizontalIdx]) {
                '-' {
                    $validStartingMoves += [Tuple]::Create(0, 1)
                }
                '7' {
                    $validStartingMoves += [Tuple]::Create(0, 1)
                }
                'J' {
                    $validStartingMoves += [Tuple]::Create(0, 1)
                }
            }
        }
    }
}

$distances = @()
$pipePieces = @{}
foreach ($startingMove in $validStartingMoves) {
    $i = $startCoord.Item1 + $startingMove.Item1
    $j = $startCoord.Item2 + $startingMove.Item2
    if ($startingMove.Item1 -eq 1) {
        $lastDirection = "north"
    }
    elseif ($startingMove.Item1 -eq -1) {
        $lastDirection = "south"
    }
    elseif ($startingMove.Item2 -eq -1) {
        $lastDirection = "west"
    }
    elseif ($startingMove.Item2 -eq 1) {
        $lastDirection = "east"
    }

    $nextPipe = ''
    $distance = 0
    while ($nextPipe -ne 'S') {
        $nextPipe = $pipesSketch[$i][$j]
        $distance++
        $pipePieces[$distance] = [Tuple]::Create($nextPipe, [Tuple]::Create($i, $j))
        $nextCoords = $pipeDir["$nextPipe"]
        switch ($lastDirection) {
            "north" { 
                switch ($nextPipe) {
                    '|' {
                        $i += $nextCoords.Item1
                        $lastDirection = "north"
                    }
                    'L' {
                        $j += $nextCoords.Item2
                        $lastDirection = "east"
                    }
                    'J' {
                        $j += $nextCoords.Item2
                        $lastDirection = "west"
                    }
                }
             }
            "south" {
                switch ($nextPipe) {
                    '|' {
                        $i -= $nextCoords.Item1
                        $lastDirection = "south"
                    }
                    'F' {
                        $j += $nextCoords.Item2
                        $lastDirection = "east"
                    }
                    '7' {
                        $j += $nextCoords.Item2
                        $lastDirection = "west"
                    }
                }
            }
            "west" {
                switch ($nextPipe) {
                    '-' {
                        $j -= $nextCoords.Item2
                        $lastDirection = "west"
                    }
                    'L' {
                        $i -= $nextCoords.Item1
                        $lastDirection = "south"
                    }
                    'F' {
                        $i -= $nextCoords.Item1
                        $lastDirection = "north"
                    }
                }
            }
            "east" {
                switch ($nextPipe) {
                    '-' {
                        $j += $nextCoords.Item2
                        $lastDirection = "east"
                    }
                    'J' {
                        $i -= $nextCoords.Item1
                        $lastDirection = "south"
                    }
                    '7' {
                        $i -= $nextCoords.Item1
                        $lastDirection = "north"
                    }
                }
            }
            Default {}
        }
    }
    $distances += $distance
}

$distComp = $distances | Group-Object
if ($distComp.Count -eq $distances.Count) {
    $farthestDistance = $distances[0] / 2
}
else {
    throw "Distances were not the same."
}

Write-Host "Part 1 Solution"
Write-Host "Farthest distance from start:" $farthestDistance

$blankSketch = @()
foreach ($line in $pipesSketch) {
    $blankSketch += $line.Replace('-', ' ').Replace('7', ' ').Replace('|', ' ').Replace('J', ' ').Replace('F', ' ').Replace('L', ' ').Replace('S', ' ')
}
for ($i = 1; $i -le $distances[0] * 2; $i++) {
    $pipePiece = $pipePieces[$i]
    $pipeCoords = $pipePiece.Item2
    $j = $pipeCoords.Item1
    $k = $pipeCoords.Item2
    $blankSketch[$j] = $blankSketch[$j].Remove($k, 1).Insert($k, $pipePiece.Item1)
}
$blankSketch | Out-File -Path ./sanityCheckMap.txt