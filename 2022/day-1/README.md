# Day 1: Calorie Counting

Day 1's puzzle involved finding calorie totals carried by elves in our adventure to find star fruit for Santa's reindeer. You can view the full description of the puzzle at the Advent of Code website: [Day 1 - Advent of Code 2022](https://adventofcode.com/2022/day/1). I solved this puzzle using PowerShell.

## Part 1

For part 1, we needed to find which elf was carrying the most calories in their pack. The input data is composed of groups of numbers, each on their own line, divided by empty lines to simulate the elve's packs. I downloaded my puzzle data, which is stored in `input.txt`. I used `Get-Content` to retrieve the data to a variable, so I could easily access each line from the file from the array PowerShell stored it in. After that, I used a `foreach` loop to sum up each elf's individual total calories and stored these values in a list. I then just had to sort the list using `Sort-Object -Descending` to find the largest value, which was the solution to the puzzle.

## Part 2

For part 2, we were asked to find the total of the top 3 highest calorie carrying elves. Since this used the same input data from Part 1, this part was extremely easy. I already had my sorted list, so I simply needed to sum the first three entries of the list to get the solution to the puzzle.