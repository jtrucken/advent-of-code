# Day 3: Rucksack Reorganization

For Day 3's puzzle, we were finding items within the elves' rucksacks (represented by strings of upper- and lowercase letters). You can view the full description of the puzzle at the Advent of Code website: [Day 3 - Advent of Code 2022](https://adventofcode.com/2022/day/3). I solved this puzzle using Python 3. Originally, I wanted to use Bash, but this puzzle was extra complicated, so I decided to brush up on my Python skills instead.

## Part 1

For part 1, we needed to find the sum of the priorities of the unique item (either an upper- or lowercase letter) in each elf's rucksack. To do this, we needed to split the string in half and then make use of the `set` type in order to find the common character between the two substrings. To do so, we intersected the sets created from the two string halves, which returns only the items shared by the sets. In this case, there is only one item returned, which is the one we are looking for. By using this returned letter as a key to a dictionary of the priority values defined before hand, we could find the priority value for the rucksack and add it to our total priority.

## Part 2

For part 2, we needed to find the sum of the priorities of the unique item in the rucksacks of groups of three elves, representing badges carried by them. To do this, I first built list of lists of the groups of three. I then looped through this list, again using set intersections to return the common value from each group of three. I put this into the priority value dictionary to retrieve the value to add to the total priority sum.

Although I used a dictionary for my priorities, I did see some other solutions using the index of the letter in a string of all the letters or the `ord()` value for the letter, which I probably would have done given a second go at this puzzle.