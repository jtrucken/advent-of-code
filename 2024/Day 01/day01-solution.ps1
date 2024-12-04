# Solution for Advent of Code 2024 Day 01
# Created 02 Dec 2024 by Jack Truckenmiller

# Part 1 Goal: Find the sum of distances between location IDs

# Input file contains two columns of numbers separated by three
# spaces each.

# Get-Content gives us these lines from the file in an array
$locationIDLists = Get-Content ./day01-input.txt

$list1 = [System.Collections.Generic.List[int]]::new()
$list2 = [System.Collections.Generic.List[int]]::new()
foreach ($locationIDPair in $locationIDLists) {
    $id1, $id2 = $locationIDPair -split '  '
    $list1.Add([int]$id1)
    $list2.Add([int]$id2)
}
$list1.Sort()
$list2.Sort()
$diffTotal = 0
for ($i = 0; $i -lt $list1.Count; $i++) {
    $diffTotal = $diffTotal + [Math]::Abs($list1[$i] - $list2[$i])
}
Write-Host "The sum of the differences in location ID numbers is: " $diffTotal

# Part 2 Goal: Find the similarity score between the two lists (sum of
# numbers from the first list multiplied by the number of times they 
# appear in the second list, not unique in the first list)

$similarityScore = 0
$scoreMap = @{}
foreach ($list1Item in $list1) {
    if ($scoreMap.Keys -contains $list1Item) {
        $similarityScore = $similarityScore + $scoreMap[$list1Item] 
    }
    else {
        $appearances = 0
        foreach ($list2Item in $list2) {
            if ($list1Item -eq $list2Item) {
                $appearances++
            }
        }
        $score = $list1Item * $appearances
        $similarityScore = $similarityScore + $score
        $scoreMap.Add($list1Item, $score)
    }
}
Write-Host "The similarity score is: " $similarityScore