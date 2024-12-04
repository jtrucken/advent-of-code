# Day 2: Mull It Over

> "Our computers are having issues, so I have no idea if we have any Chief Historians in stock! You're welcome to check the warehouse, though," says the mildly flustered shopkeeper at the [North Pole Toboggan Rental Shop](https://adventofcode.com/2020/day/2). The Historians head out to take a look.
>
> The shopkeeper turns to you. "Any chance you can see why our computers are having issues again?"
>
> The computer appears to be trying to run a program, but its memory (your puzzle input) is *corrupted*. All of the instructions have been jumbled up!
>
> It seems like the goal of the program is just to *multiply some numbers*. It does that with instructions like `mul(X,Y)`, where `X` and `Y` are each 1-3 digit numbers. For instance, `mul(44,46)` multiplies `44` by `46` to get a result of `2024`. Similarly, `mul(123,4)` would multiply `123` by `4`.
>
> However, because the program's memory has been corrupted, there are also many invalid characters that should be *ignored*, even if they look like part of a `mul` instruction. Sequences like `mul(4*`, `mul(6,9!`, `?(12,34)`, or `mul ( 2 , 4 )` do *nothing*.

The above is a snippet of the problem for Day 3. You can view the full description of the puzzle at the Advent of Code website: [Day 3 - Advent of Code 2024](https://adventofcode.com/2024/day/3). I solved this puzzle using PowerShell.

## Part 1

For part 1, we just need to find the sum of all the valid multiplications. Although this appears daunting, we just need to bust out a little regex to pull out the strings that exactly match `mul\(\d{1,3},\d{1,3}\)`. PowerShell's native `[regex]::Matches()` does this very nicely, and we simply store the resulting array in a variable. After that, we iterate through the valid commands, use a little more regex to pull out the digits, multiply the digits together, and add them to the sum! I am quite proud of how cleanly this solution came out.

## Part 2

Part 2 adds some conditional logic into the mix in the form of `do()` and `don't()` instructions. The multiplication commands start out enabled, but once a `don't()` instruction appears, any `mul` commands that follow are ignored until the next `do()` instruction appears. At first, I was going to get complicated and try to split the strings on the `do()`s and `don't()`s, but then I realized it would be much easier to simply expand my regex to also catch the `do()` and `don't()` tokens. With them now a part of the array, I processed things almost the same other than some added conditional logic that would enable or disable the multiplication whenever a `do()` or `don't()` was found. This was another really clean looking solution that I'm quite happy with.