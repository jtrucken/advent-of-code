# Solution for Advent of Code 2024 Day 03
# Created 03 Dec 2024 by Jack Truckenmiller

# Part 1 Goal: Find the sum of multiplied numbers from corrupted data

# Input file contains single lines of instructions, but the only valid
# instructions are in the exact format of mul([0-9]{1,3},[0-9]{1,3})

# Get-Content gives us these lines from the file in an array
$corruptedMemory = Get-Content ./day03-input.txt

$result = 0
foreach ($lineOfMemory in $corruptedMemory) {
    $validInstructions = [regex]::Matches($lineOfMemory, "mul\(\d{1,3},\d{1,3}\)")
    foreach ($validInstruction in $validInstructions) {
        $numbers = [regex]::Matches($validInstruction, "\d+")
        $result = $result + ([int]($numbers[0].Value) * [int]($numbers[1].Value)) 
    }
}
Write-Host "The sum of all the multiplications is: " $result

# Part 2 Goal: Mostly the same as part 1, but only consider multiplication
# operations that follow a do() instruction (other than the first part, which
# should also be considered)

$result2 = 0
$enabled = $true
foreach ($lineOfMemory in $corruptedMemory) {
    $validInstructions = [regex]::Matches($lineOfMemory, "(mul\(\d{1,3},\d{1,3}\)|(do\(\)|don't\(\)))")
    foreach ($validInstruction in $validInstructions) {
        if ($validInstruction -match "mul\(\d{1,3},\d{1,3}\)") {
            if ($enabled) {
                $numbers = [regex]::Matches($validInstruction, "\d+")
                $result2 = $result2 + ([int]($numbers[0].Value) * [int]($numbers[1].Value)) 
            }
        }
        else {
            $enabled = $validInstruction -match "do\(\)" ? $true : $false
        }
    }
}
Write-Host "The sum of all the multiplications under the conditional logic is: " $result2