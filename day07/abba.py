#!/usr/bin/env python
from sys import argv
import re

def has_abba(tok) :
    c = list(tok)
    for i in range(0, len(c) - 3) :
        if c[i] == c[i+3] and c[i+1] == c[i+2] and c[i] != c[i+1] :
            return True

    return False

n = 0

script, filename = argv
with open(filename) as f :
    for line in f :
        line = line.rstrip("\n")

        tok = re.split('[\[\]]', line)

        have_abba = [False, False]
        for i in range(0, len(tok)) :
            if has_abba(tok[i]) :
                have_abba[i % 2] = True

        if have_abba[0] and not have_abba[1] :
            print "GOOD => %s" % line
            n = n + 1
        else :
            print "BAD  => %s" % line

print n
