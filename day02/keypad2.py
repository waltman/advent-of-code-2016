#!/usr/bin/env python
from sys import argv

keypad = [
    [0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 1, 0, 0, 0],
    [0, 0, 2, 3, 4, 0, 0],
    [0, 5, 6, 7, 8, 9, 0],
    [0, 0,'A','B','C', 0, 0],
    [0, 0, 0, 'D', 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0] ]

(x, y) = (3, 1)
code = []

script, filename = argv
with open(filename) as f :
    for line in f :
        line = line.rstrip("\n")
        for move in line :
            if move == 'U' and keypad[y-1][x] != 0 :
                y = y - 1
            elif move == 'D' and keypad[y+1][x] != 0 :
                y = y + 1
            elif move == 'L' and keypad[y][x-1] != 0 :
                x = x - 1
            elif move == 'R' and keypad[y][x+1] != 0:
                x = x + 1

        code.append(keypad[y][x])

print ''.join(map(str,code))
