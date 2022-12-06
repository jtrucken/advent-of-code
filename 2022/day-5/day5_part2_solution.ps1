using namespace System.Collections.Generic

# Solution for Part 2 of Advent of Code 2022 Day 5
# Created 5 Dec 2022 by Jack Truckenmiller in collaboration with https://github.com/bgalliford
# Much of this code is duplicated from day5_part1_solution.ps1 
# (https://github.com/jtrucken/advent-of-code/blob/main/2022/day-5/day5_part1_solution.ps1) 
# with modifications in the stack moving logic to solve part 2's problem

# Part 2 Goal: Find the top value of nine stacks after reorganizing the stacks using a set of provided
# instructions to do so, with multiple items being able to be moved between stacks without their order
# being changed

# The problem description mentioned stacks, so using the System.Collections.Generic namespace, this array
# initializes the nine stacks used for the problem
$stacks = @([Stack[string]]::new(), [Stack[string]]::new(), [Stack[string]]::new(), [Stack[string]]::new(), 
[Stack[string]]::new(), [Stack[string]]::new(), [Stack[string]]::new(), [Stack[string]]::new(), [Stack[string]]::new())

# Push the initial values of the stacks to the nine stacks in the array, starting at the bottom of each stack in the
# input and ending at the top, therefore the top of the "stack" in the input is also the top of the Stack collection
# following the Last In First Out (LIFO) structure of a stack
$stacks[0].Push("[W]")
$stacks[0].Push("[R]")
$stacks[0].Push("[F]")
$stacks[1].Push("[T]")
$stacks[1].Push("[H]")
$stacks[1].Push("[M]")
$stacks[1].Push("[C]")
$stacks[1].Push("[D]")
$stacks[1].Push("[V]")
$stacks[1].Push("[W]")
$stacks[1].Push("[P]")
$stacks[2].Push("[P]")
$stacks[2].Push("[M]")
$stacks[2].Push("[Z]")
$stacks[2].Push("[N]")
$stacks[2].Push("[L]")
$stacks[3].Push("[J]")
$stacks[3].Push("[C]")
$stacks[3].Push("[H]")
$stacks[3].Push("[R]")
$stacks[4].Push("[C]")
$stacks[4].Push("[P]")
$stacks[4].Push("[G]")
$stacks[4].Push("[H]")
$stacks[4].Push("[Q]")
$stacks[4].Push("[T]")
$stacks[4].Push("[B]")
$stacks[5].Push("[G]")
$stacks[5].Push("[C]")
$stacks[5].Push("[W]")
$stacks[5].Push("[L]")
$stacks[5].Push("[F]")
$stacks[5].Push("[Z]")
$stacks[6].Push("[W]")
$stacks[6].Push("[V]")
$stacks[6].Push("[L]")
$stacks[6].Push("[Q]")
$stacks[6].Push("[Z]")
$stacks[6].Push("[J]")
$stacks[6].Push("[G]")
$stacks[6].Push("[C]")
$stacks[7].Push("[P]")
$stacks[7].Push("[N]")
$stacks[7].Push("[R]")
$stacks[7].Push("[F]")
$stacks[7].Push("[W]")
$stacks[7].Push("[T]")
$stacks[7].Push("[V]")
$stacks[7].Push("[C]")
$stacks[8].Push("[J]")
$stacks[8].Push("[W]")
$stacks[8].Push("[H]")
$stacks[8].Push("[G]")
$stacks[8].Push("[R]")
$stacks[8].Push("[S]")
$stacks[8].Push("[V]")

# The input file contained the depiction of the stacks initially, but this was cut out and put in its own file,
# leaving only lines of instructions for how to reorganize the stacks

# Get-Content gives us these lines from the file in an array
$instructions = Get-Content ./2022/day-5/input.txt

# Initialize a stack to hold the multiple moved values in reverse order
$storageStack = [Stack[string]]::new()

foreach ($instruction in $instructions) {

    # This split came from https://github.com/bgalliford and is much more effective than my initial attempt
    # at pulling the numbers of the instruction string
    $split1, [int]$numberToMove, $split2, [int]$moveFromStack, $split3, [int]$moveToStack = $instruction.Split(" ")
    # Loop through for the number of values to be popped off the origin stack and push them onto the storage stack
    for ($i =0; $i -lt $numberToMove; $i++) {
        $storageStack.Push($stacks[($moveFromStack - 1)].Pop())
    }
    # Pop the contents of the storage stack and push them to the destination stack until the storage stack is empty,
    # thereby moving retaining the original order of the values stacked
    while ($storageStack.Count -gt 0) {
        $stacks[($moveToStack - 1)].Push($storageStack.Pop())
    }
}

Write-Host "Part 2 Solution"
Write-Host "The top box on each stack is:"
foreach ($topBox in $stacks) {
    try {
        # Peek() lets us see the top of the stack without removing the value
        Write-Host $topBox.Peek()
    }
    catch {
        Write-Host ""
    }
}