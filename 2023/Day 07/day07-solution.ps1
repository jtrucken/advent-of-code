# Solution for Advent of Code 2023 Day 07
# Created 07 Dec 2023 by Jack Truckenmiller

# Part 1 Goal: Find total winnings based on hands based
# the sum of the hand's bid multiplied by its rank (how
# strong the hand's type is compared to all other types)
# Part 2 Goal: ???

# Input file contains lines with card hands and bids
# separated by a space

using namespace System
using namespace System.Collections.Generic

# Get-Content gives us these lines from the file in an array
$hands = Get-Content ./day07-input.txt

$fiveOfaKinds = [List[Tuple]]::new()
$fourOfaKinds = [List[Tuple]]::new()
$fullHouse = [List[Tuple]]::new()
$threeOfaKinds = [List[Tuple]]::new()
$twoPairs = [List[Tuple]]::new()
$onePairs = [List[Tuple]]::new()
$highCards = [List[Tuple]]::new()
foreach ($hand in $hands) {
    $cards, $bid = $hand -split "\s+"
    switch -Regex ($cards) {
        'A{5}|K{5}|Q{5}|J{5}|T{5}|9{5}|8{5}|7{5}|6{5}|5{5}|4{5}|3{5}|2{5}' {
            $fiveOfaKinds.Add([Tuple]::Create($cards,[int]$bid))
        }
        'A{4}|K{4}|Q{4}|J{4}|T{4}|9{4}|8{4}|7{4}|6{4}|5{4}|4{4}|3{4}|2{4}' {
            $fourOfaKinds.Add([Tuple]::Create($cards,[int]$bid))
        }
        'A{3}|K{3}|Q{3}|J{3}|T{3}|9{3}|8{3}|7{3}|6{3}|5{3}|4{3}|3{3}|2{3}' {
            $fullHouse.Add([Tuple]::Create($cards,[int]$bid))
        }
        'A{3}|K{3}|Q{3}|J{3}|T{3}|9{3}|8{3}|7{3}|6{3}|5{3}|4{3}|3{3}|2{3}' {
            $threeOfaKinds.Add([Tuple]::Create($cards,[int]$bid))
        }
        'A{5}|K{5}|Q{5}|J{5}|T{5}|9{5}|8{5}|7{5}|6{5}|5{5}|4{5}|3{5}|2{5}' {
            $twoPairs.Add([Tuple]::Create($cards,[int]$bid))
        }
        'A{5}|K{5}|Q{5}|J{5}|T{5}|9{5}|8{5}|7{5}|6{5}|5{5}|4{5}|3{5}|2{5}' {
            $onePairs.Add([Tuple]::Create($cards,[int]$bid))
        }
        default {
            $highCards.Add([Tuple]::Create($cards,[int]$bid))
        }
    }
}