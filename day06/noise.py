#!/usr/bin/env python
from sys import argv
import collections

used = []

script, filename = argv
with open(filename) as f :
    for line in f :
        line = line.rstrip("\n")
        for i in range(0, len(line)) :
            if len(used) == i :
                used.append(collections.defaultdict(int))
            s = line[i]
            used[i][s] = used[i][s] + 1

s = ""
t = ""

for d in used :
    k = sorted(d, key=d.get)
    s = s + k[-1]
    t = t + k[0]

print s
print t

