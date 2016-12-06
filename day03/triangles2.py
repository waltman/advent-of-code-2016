#!/usr/bin/env python
from sys import argv

num_good = 0
c1 = []
c2 = []
c3 = []

script, filename = argv
with open(filename) as f :
    for line in f :
        line = line.rstrip("\n")
        s = map(int, line.split())
        c1.append(s[0])
        c2.append(s[1])
        c3.append(s[2])

c = c1 + c2 + c3

for k in range(0, len(c), 3) :
    s = c[k:k+3]
    bad = False
    for i in range(0, 2) :
        for j in range(i+1, 3) :
            if s[i] + s[j] <= s[3-i-j] :
                bad = True
                break
    if not bad :
        num_good = num_good + 1

print num_good

