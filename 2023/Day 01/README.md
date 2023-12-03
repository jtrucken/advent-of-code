# Day 1: Trebuchet?!

> You try to ask why they can't just use a [weather machine](https://adventofcode.com/2015/day/1) ("not powerful enough") and where they're even sending you ("the sky") and why your map looks mostly blank ("you sure ask a lot of questions") and hang on did you just say the sky ("of course, where do you think snow comes from") when you realize that the Elves are already loading you into a [trebuchet](https://en.wikipedia.org/wiki/Trebuchet) ("please hold still, we need to strap you in").
>
> As they're making the final adjustments, they discover that their calibration document (your puzzle input) has been **amended** by a very young Elf who was apparently just excited to show off her art skills. Consequently, the Elves are having trouble reading the values on the document.
>
> The newly-improved calibration document consists of lines of text; each line originally contained a specific **calibration value** that the Elves now need to recover. On each line, the calibration value can be found by combining the **first digit** and the **last digit** (in that order) to form a single **two-digit number**.

The above is a snippet of the problem for Day 1. You can view the full description of the puzzle at the Advent of Code website: [Day 1 - Advent of Code 2023](https://adventofcode.com/2023/day/1). I solved this puzzle using PowerShell.

## Part 1

For part 1, we needed to find the first and last digit from the string and combine them to form a single two-digit number. This wasn't too bad, and I used the classic `foreach` loop to go through each line of my input. I converted the string to a character array, removed the non-digits with a regex match, and then combined the first and last digits together into a single two-digit number. For lines where there was only one digit, this digit forms both part of the number, so I added in a case to handle that.

## Part 2

For part 2, we have the same task only with a new wrinkle: some of the numbers might be represented in text form. Not only that, but the numbers can be combined together (ex. twone). Ultimately, the easier and original way I solved this (with some advice from my friend [bgalliford](https://github.com/bgalliford) who figured it out before me) was to simply replace the text version of the number with a string containing the digit version of the number embeded in the string (ex. `t2o`).

I wasn't entirely satisfied doing it this way though, and I tried it two different other ways. First was replacing the text version of the number with its digit version, doing this in nine different strings that I then used my part 1 solve on to reduce to just the digits in each of the strings and comparing the index location of the digits to find what is the true first and last. The problem with this approach is that it changed the length of the string, so those index comparisons were not entirely accurate.

My second approach was to parse the string forward and backwards character-by-character. My first check was for a digit, and if I didn't find one, then I'd try to build the text version of a number instead. This does work, but the way I coded it probably doesn't use every efficiency that it could, and it came out to around 599 lines. Still, I am happy with the way it works.