# Day 2: Red-Nosed Reports

> Fortunately, the first location The Historians want to search isn't a long walk from the Chief Historian's office.
>
> While the [Red-Nosed Reindeer nuclear fusion/fission plant](https://adventofcode.com/2015/day/19) appears to contain no sign of the Chief Historian, the engineers there run up to you as soon as they see you. Apparently, they *still* talk about the time Rudolph was saved through molecular synthesis from a single electron.
>
> They're quick to add that - since you're already here - they'd really appreciate your help analyzing some unusual data from the Red-Nosed reactor. You turn to check if The Historians are waiting for you, but they seem to have already divided into groups that are currently searching every corner of the facility. You offer to help with the unusual data.
>
> The unusual data (your puzzle input) consists of many *reports*, one report per line. Each report is a list of numbers called *levels* that are separated by spaces.

The above is a snippet of the problem for Day 2. You can view the full description of the puzzle at the Advent of Code website: [Day 2 - Advent of Code 2024](https://adventofcode.com/2024/day/2). I solved this puzzle using PowerShell.

## Part 1

For part 1, we needed to find the number of safe reports. A safe report is one that only increases or decreases, and the level can not change less than 1 or more than 3. This part wasn't too bad to solve, as I simply took each row, split it into an array, and then took the difference of the values `i` and `i + 1` until I reached the end of the array. After `i = 0`, I also compared the current difference with the difference from the previous pair to make sure they were both either positive or negative. I used a boolean flag to keep track of if a report was safe or not, breaking out of the loop for a row as it was determined to be unsafe.

## Part 2

Part 2 added the wrinkle of their being a "problem dampener" that could remove one problematic level per report, and the report would remain safe as long as no other levels turned out to be unsafe. My attempt to solve this involved adding a second flag to catch the first problem that appeared and simply skip it. However, despite my best efforts, I can't actually get the algorithm to correctly solve the puzzle. I know from a frustrated guess with the original result I got that I can get within an error of one to the solution (either 1 too high or 1 too low). The code for part 2 is my last attempt to get the error to resolve, but I decided to move on so I don't get bogged down on this puzzle and fall behind.