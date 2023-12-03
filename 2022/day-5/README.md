# Day 5: Supply Stacks

Day 5's puzzle involved finding the top crates from a collection of stacks after the elves had moved the crates around according to a set of given instructions. You can view the full description of the puzzle at the Advent of Code website: [Day 5 - Advent of Code 2022](https://adventofcode.com/2022/day/5). I solved this puzzle using PowerShell (back to the work week, so experimentation with other languages goes on pause).

## Part 1

For part 1, the elves' crane could move one box at a time from one stack to another. Since the puzzle description mentioned stacks, and this part clearly followed the principle of Last In First Out (LIFO), I went looking to see if PowerShell had a `Stack` type, and it does within the `System.Collections.Generic` namespace. I built an array of stacks to represent the nine different stacks of crates, then pushed the input values to the stacks (I hardcoded the inputs in because no way in heck was I going to try and parse that string in my limited time). I cut the input file in two, one with the actual instructions and a second showing off the boxes I was given, just to represent the input a bit more nicely. Once the stacks were built, I imported the instructions and started looping through them. Using a nice bit of code provided by [bgalliford](https://github.com/bgalliford), the instructions were split, and a `for` loop was entered, repeating based on the number of crates moved from the instructions, popping the crates from the stack specified by the instructions (this value had 1 substracted to give its stack's index in the area) and pushing the crates to the stack specified in the instructions. Once this algorithm completed, the `Peek()` method for stacks in PowerShell was used to view the top of each stack to generate the results.

## Part 2

For part 2, the elves' crane could now carry all the boxes specified in a single go, preserving their order. To accomodate for this, most of the code remained the same, but a storage stack was introduced, which stored the boxes to be moved in the opposite order they would be stacked, and then the storage stack was popped, with the values being pushed to the destination stack, thereby preserving the desired order of the boxes.