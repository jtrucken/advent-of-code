# Solution for Advent of Code 2022 Day 3
# Created 3 Dec 2022 by Jack Truckenmiller

# Part 1 Goal: Find common letter (case-sensitive) between the two halves of each input string
# Part 2 Goal: Find common letter (still case-sensitve) between groups of three from the input strings

# Dictionary definining letter priorities based on the problem definition (https://adventofcode.com/2022/day/3)
itemPriorities = {'a': 1, 'b': 2, 'c': 3, 'd': 4, 'e': 5, 'f': 6, 'g': 7, 'h': 8, 'i': 9, 'j': 10, 'k': 11, 'l': 12, 'm': 13, 
'n': 14, 'o': 15, 'p': 16, 'q': 17, 'r': 18, 's': 19, 't': 20, 'u': 21, 'v': 22, 'w': 23, 'x': 24, 'y': 25, 'z': 26, 'A': 27,
'B': 28, 'C': 29, 'D': 30, 'E': 31, 'F': 32, 'G': 33, 'H': 34, 'I': 35, 'J': 36, 'K': 37, 'L': 38, 'M': 39, 'N': 40, 'O': 41, 
'P': 42, 'Q': 43, 'R': 44, 'S': 45, 'T': 46, 'U': 47, 'V': 48, 'W': 49, 'X': 50, 'Y': 51, 'Z': 52}
prioritiesSum = 0

# Input file is lines of strings containing upper and lower case letters representing the rucksacks carried
# by the elves. Each letter represents an item in the sack

# Opens the file to loop through the lines. For Part 1, we divide the lines in half evenly to find the
# common letter (case-sensitive) between them. We find that letter's priority, and then add it to the
# total sum of the priorities
with open("2022/day-3/input.txt", "r") as ruckSacks:
    for ruckSack in ruckSacks:
        # Using sets with & intersects the sets, returning only the values shared between them
        sharedItem = set(ruckSack[0:len(ruckSack)//2]) & set(ruckSack[len(ruckSack)//2:])
        prioritiesSum += itemPriorities[sharedItem.pop()]

print("Part 1 Solution")
print("The sum of the priorities for the item types in the rucksacks is: " + str(prioritiesSum) + ".")

prioritiesSum = 0
elfGroup = []
elfTrios = []
# Opens the file and loops through the lines. For part 2, we are finding the common item between each
# group of 3. Therefore, the first thing we do is build out our groups of three using lists
with open("2022/day-3/input.txt", "r") as ruckSacks:
    for ruckSack in ruckSacks:
        # We need to use the rstrip method to take off the newline character or else that is considered common
        elfGroup.append(ruckSack.rstrip())

        if len(elfGroup) == 3:
            elfTrios.append(list(elfGroup))
            elfGroup.clear()

# Loop through the groups of three, and uses sets once again to get the common item between them        
for trio in elfTrios:
    sharedItem = set(trio[0]).intersection(set(trio[1]), set(trio[2]))
    if len(sharedItem) == 1:
        prioritiesSum += itemPriorities[sharedItem.pop()]

print("Part 2 Solution")
print("The sum of the priorities for badges in the rucksacks is: " + str(prioritiesSum) + ".")