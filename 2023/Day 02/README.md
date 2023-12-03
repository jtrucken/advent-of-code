# Day 2: Cube Conundrum

> You're launched high into the atmosphere! The apex of your trajectory just barely reaches the surface of a large island floating in the sky. You gently land in a fluffy pile of leaves. It's quite cold, but you don't see much snow. An Elf runs over to greet you.
>
> The Elf explains that you've arrived at **Snow Island** and apologizes for the lack of snow. He'll be happy to explain the situation, but it's a bit of a walk, so you have some time. They don't get many visitors up here; would you like to play a game in the meantime?
>
> As you walk, the Elf shows you a small bag and some cubes which are either red, green, or blue. Each time you play this game, he will hide a secret number of cubes of each color in the bag, and your goal is to figure out information about the number of cubes.
>
> To get information, once a bag has been loaded with cubes, the Elf will reach into the bag, grab a handful of random cubes, show them to you, and then put them back in the bag. He'll do this a few times per game.
>
> You play several games and record the information from each game (your puzzle input). Each game is listed with its ID number (like the `11` in `Game 11: ...`) followed by a semicolon-separated list of subsets of cubes that were revealed from the bag (like `3 red, 5 green, 4 blue`).

The above is a snippet of the problem for Day 2. You can view the full description of the puzzle at the Advent of Code website: [Day 2 - Advent of Code 2023](https://adventofcode.com/2023/day/2). I solved this puzzle using PowerShell.

## Part 1

For part 1, we needed to find what games were actually playable if the bag only had only 12 red cubes, 13 green cubes, and 14 blue cubes. This isn't too bad since the data are very clearly organized. I simply looped through the lines and split the strings into smaller and smaller pieces based on the delimiters given. I was able to loop through the resulting arrays to evaluate whether a game was playable or not (I used a hashtable to define the colors and their limits, so I only needed one `if` statement to evaluate the limits). I used a simple flag to keep track of whether a game was playable or not, only adding that game's ID to the sum if the flag remained true.

## Part 2

Part 2 wanted us to evaluate the minimum number of cubes needed for each game. Once we determined that, we needed to multiply the three values together (getting the set's power), then get the sum of the set powers for all the games. This really wasn't too bad, since the loops and string splits from part 1 were all reusable. I then stored the values for the colors of each game in generic lists, which I sorted once all sets in a game had been evaluated, pulling out the highest value from the sorted lists and multiplying them together.

I originally had two copies of the loop: one for part 1 and part 2. I realized this could be simplified to a single loop, resulting in the final solution present.