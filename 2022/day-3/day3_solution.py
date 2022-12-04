# Solution for Advent of Code 2022 Day 3
# Created 3 Dec 2022 by Jack Truckenmiller

itemPriorities = {'a': 1, 'b': 2, 'c': 3, 'd': 4, 'e': 5, 'f': 6, 'g': 7, 'h': 8, 'i': 9, 'j': 10, 'k': 11, 'l': 12, 'm': 13, 
'n': 14, 'o': 15, 'p': 16, 'q': 17, 'r': 18, 's': 19, 't': 20, 'u': 21, 'v': 22, 'w': 23, 'x': 24, 'y': 25, 'z': 26, 'A': 27,
'B': 28, 'C': 29, 'D': 30, 'E': 31, 'F': 32, 'G': 33, 'H': 34, 'I': 35, 'J': 36, 'K': 37, 'L': 38, 'M': 39, 'N': 40, 'O': 41, 
'P': 42, 'Q': 43, 'R': 44, 'S': 45, 'T': 46, 'U': 47, 'V': 48, 'W': 49, 'X': 50, 'Y': 51, 'Z': 52}
prioritiesSum = 0

with open("2022/day-3/input.txt", "r") as ruckSacks:
    for ruckSack in ruckSacks:
        sharedItem = set(ruckSack[0:len(ruckSack)//2]) & set(ruckSack[len(ruckSack)//2:])
        prioritiesSum += itemPriorities[sharedItem.pop()]

print("Part 1 Solution")
print("The sum of the priorities for the item types in the rucksacks is: " + str(prioritiesSum) + ".")

prioritiesSum = 0
elfGroup = []
elfTrios = []
with open("2022/day-3/input.txt", "r") as ruckSacks:
    for ruckSack in ruckSacks:
        elfGroup.append(ruckSack.rstrip())

        if len(elfGroup) == 3:
            elfTrios.append(list(elfGroup))
            elfGroup.clear()
        
for trio in elfTrios:
    print(trio)
    sharedItem = set(trio[0]).intersection(set(trio[1]), set(trio[2]))
    print(sharedItem)
    if len(sharedItem) == 1:
        prioritiesSum += itemPriorities[sharedItem.pop()]
        print(prioritiesSum)

print("Part 2 Solution")
print("The sum of the priorities for badges in the rucksacks is: " + str(prioritiesSum) + ".")