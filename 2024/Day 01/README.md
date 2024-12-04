# Day 1: Historian Hysteria

> You haven't even left yet and the group of Elvish Senior Historians has already hit a problem: their list of locations to check is currently *empty*. Eventually, someone decides that the best place to check first would be the Chief Historian's office.
>
> Upon pouring into the office, everyone confirms that the Chief Historian is indeed nowhere to be found. Instead, the Elves discover an assortment of notes and lists of historically significant locations! This seems to be the planning the Chief Historian was doing before he left. Perhaps these notes can be used to determine which locations to search?
>
> Throughout the Chief's office, the historically significant locations are listed not by name but by a unique number called the *location ID*. To make sure they don't miss anything, The Historians split into two groups, each searching the office and trying to create their own complete list of location IDs.
>
> There's just one problem: by holding the two lists up *side by side* (your puzzle input), it quickly becomes clear that the lists aren't very similar. Maybe you can help The Historians reconcile their lists?

The above is a snippet of the problem for Day 1. You can view the full description of the puzzle at the Advent of Code website: [Day 1 - Advent of Code 2024](https://adventofcode.com/2024/day/1). I solved this puzzle using PowerShell.

## Part 1

For part 1, we needed to find the sum of the differences in the location IDs from the two lists. This was a relatively simple solve as I used a `foreach` loop on the input to split the rows and store the values in two separate lists, which I then sorted before using a `for` loop to iterate through them, take the absolute value of the difference between the values, and summed these differences to get the final result.

## Part 2

For part 2, we needed to find the similarity score between the two lists. This meant finding how often a number from the first list appeared in the second, multiplying that number by the number of repititions, and then summing all these values, which could repeat. Since numbers could appear multiple times in the first list, I decided to save time by storing the numbers and their individual similarity scores in a hashtable, so I could simple reference the score and add it to the sum if that number came up again. If a number wasn't in the hashtable yet, I would compare it to all the values in the second list using a `foreach` loop to determine its score, then add it to the hashtable.