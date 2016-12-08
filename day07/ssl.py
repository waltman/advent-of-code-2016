#!/usr/bin/env python
from sys import argv
import re

def find_aba(s) :
    c = list(s)
    a = []

    for i in range(0, len(c) - 2) :
        if c[i] == c[i+2] and c[i] != c[i+1] :
            a.append(s[i:i+3])

    return a

def has_ssl(aba, bab) :
    
    for s in aba :
        c = list(s)
        rev = c[1] + c[0] + c[1]
        for t in bab :
            if t == rev :
                return True

    return False

n = 0

script, filename = argv
with open(filename) as f :
    for line in f :
        line = line.rstrip("\n")

        tok = re.split('[\[\]]', line)

        aba = []
        bab = []
        for i in range(0, len(tok)) :
            if i % 2 == 0 :
                abas = find_aba(tok[i])
                if len(abas) > 0 :
                    aba = aba + abas

            else :
                abas = find_aba(tok[i])
                if len(abas) > 0 :
                    bab = bab + abas

        if has_ssl(aba, bab) :
            print "GOOD => %s" % line
            n = n + 1
        else :
            print "BAD  => %s" % line

print n
