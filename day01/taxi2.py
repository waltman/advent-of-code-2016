#!/usr/bin/env python
from sys import argv
from numpy import *

dirv = {}
dirv['N'] = array([0, 1])
dirv['S'] = array([0,-1])
dirv['E'] = array([1, 0])
dirv['W'] = array([-1,0])

r = {}
r['N'] = 'E'
r['E'] = 'S'
r['S'] = 'W'
r['W'] = 'N'

l = {}
l['N'] = 'W'
l['E'] = 'N'
l['S'] = 'E'
l['W'] = 'S'

visited = {}

pos = array([0, 0])
dir = 'N'
done = False

script, filename = argv
with open(filename) as f :
    for line in f :
        line = line.rstrip("\n")
        moves = line.split(", ")
        for move in moves :
            turn = move[:1]
            n = int(move[1:])

            if turn == "R" :
                dir = r[dir]
            else :
                dir = l[dir]

            v = dirv[dir]
            for i in range(0,n) :
                pos = pos + v
                k = "%d %d" % (pos[0], pos[1])
                if k in visited :
                    print "visited %s twice!" % pos
                    done = True
                    break
                else :
                    visited[k] = 1
                
            if done :
                break

if done :
    print pos
    print abs(pos[0]) + abs(pos[1])
else :
    print "Santa didn't visit any location twice"
    
