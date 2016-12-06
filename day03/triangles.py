#!/usr/bin/env python
from sys import argv
from numpy import *

num_good = 0

script, filename = argv
with open(filename) as f :
    for line in f :
        line = line.rstrip("\n")
        s = map(int, line.split())
        bad = False
        for i in range(0, 2) :
            for j in range(i+1, 3) :
                if s[i] + s[j] <= s[3-i-j] :
                    bad = True
                    break
        if not bad :
            num_good = num_good + 1

print num_good

