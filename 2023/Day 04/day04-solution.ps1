# Solution for Advent of Code 2023 Day 04
# Created 04 Dec 2023 by Jack Truckenmiller

# Part 1 Goal: Find the sum of point values for scratchcards
# Part 2 Goal: Find how many scratchcards you end up with
# when each winning number wins a copy of +n cards from the
# current card's ID.

# Input file contains single lines of cards with their IDs, 
# winning numbers, and numbers actually on the card. IDs are
# separated from the numbers by a colon, and the numbers are
# separated into two space delimited lists by a pipe (|)

using namespace System.Collections.Generic

# Get-Content gives us these lines from the file in an array
$cards = Get-Content ./day04-input.txt

$pointTotal = 0
$totalCards = [List[int]]::new()
for ($i = 0; $i -lt $cards.Count; $i++) {
    $totalCards.Add(1)
}
foreach ($card in $cards) {
    $cardID, $numbers = $card -split ": "
    $ID = $cardID -split "\s" | Where-Object {$_ -match "\d"}
    $idIndex = [int]$ID - 1
    $i = 1
    $winningNumbers, $cardNumbers = $numbers -split "\| "
    $winningNumbersArr = $winningNumbers -split "\s"
    $winningNumbersInt = [List[int]]::new()
    foreach ($winningNumber in $winningNumbersArr) {
        if ($winningNumber) {
            $winningNumbersInt.Add([int]$winningNumber)
        }
    }
    $cardNumbersArr = $cardNumbers -split "\s"
    $cardNumbersInt = [List[int]]::new()
    foreach ($cardNumber in $cardNumbersArr) {
        if ($cardNumber) {
            $cardNumbersInt.Add([int]$cardNumber)
        }
    }
    $cardValue = 0
    foreach ($number in $cardNumbersInt) {
        if ($winningNumbersInt -contains $number) {
            switch ($cardValue) {
                0 { $cardValue++ }
                default { $cardValue = $cardValue * 2 }
            }
            if ($index + $i -lt $cards.Count) {
                $totalCards[$idIndex + $i] = $totalCards[$idIndex + $i] + (1 * $totalCards[$idIndex])
                $i++
            }
        }
    }
    $pointTotal += $cardValue
}
Write-Host "Part 1 Solution"
Write-Host "Sum of card point values:" $pointTotal
$cardsTotal = 0
foreach ($card in $totalCards) {
    $cardsTotal += $card
}
Write-Host "Part 2 Solution"
Write-Host "Final number of scratchcards:" $cardsTotal