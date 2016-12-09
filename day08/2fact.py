#!/usr/bin/env python
from sys import argv
import re

def init_screen(rows, cols) :
    screen = [[' ' for x in range(cols)] for y in range(rows)]
    return screen

def print_screen(screen, rows, cols) :
    for row in range(rows) :
        for col in range(cols) :
            print screen[row][col],
        print
    print

def do_rect(screen, tok) :
    wh = tok[1].split('x')
    w = int(wh[0])
    h = int(wh[1])
    for row in range(h) :
        for col in range(w) :
            screen[row][col] = '#'

def do_rotate_col(screen, tok, rows) :
    tok2 = tok[2].split('=')
    col = int(tok2[1])
    n = int(tok[4])

    for i in range(1,n+1) :
        tmp = screen[rows-1][col]
        for row in range(rows-1, 0, -1) :
            screen[row][col] = screen[row-1][col]
        screen[0][col] = tmp

def do_rotate_row(screen, tok, cols) :
    tok2 = tok[2].split('=')
    row = int(tok2[1])
    n = int(tok[4])

    for i in range(1, n+1) :
        tmp = screen[row][cols-1]
        for col in range(cols-1, 0, -1) :
            screen[row][col] = screen[row][col-1]
        screen[row][0] = tmp

def num_lit(screen, rows, cols) :
    n = 0

    for row in range(rows) :
        for col in range(cols) :
            if screen[row][col] == '#' :
                n = n + 1

    return n

#ROWS = 3
#COLS = 7
ROWS = 6
COLS = 50
screen = init_screen(ROWS, COLS)
print_screen(screen, ROWS, COLS)

script, filename = argv
with open(filename) as f :
    for line in f :
        line = line.rstrip("\n")
        print line
        tok = line.split(' ')
        if tok[0] == "rect" :
            do_rect(screen, tok)
        elif tok[0] == 'rotate' :
            if tok[1] == 'column' :
                do_rotate_col(screen, tok, ROWS)
            else :
                do_rotate_row(screen, tok, COLS)
                
        print_screen(screen, ROWS, COLS)
    
print num_lit(screen, ROWS, COLS)
