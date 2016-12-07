#!/usr/bin/env python
from sys import argv
import re
import collections

def real_room(name, checksum) :
    cnt = collections.defaultdict(int)

    for s in name :
        if s != '-' :
            cnt[s] = cnt[s] + 1

    sorted_keys = sorted(cnt.keys(), cmp=lambda x,y: cmp(cnt[y],cnt[x]) or cmp(x,y))
    if len(sorted_keys) < 5 :
        return False
    else :
        return checksum == "".join(sorted_keys[0:5])

def decode(name, sector) :
    decoded = ""
    for c in name :
        decoded = decoded + rotate(c, sector)

    return decoded

def rotate(c, cnt) :
    if c == "-" :
        return " "
    else :
        n = ord(c) - ord("a") + int(cnt)
        n = n % 26
        return chr(n + ord("a"))

total = 0

script, filename = argv
with open(filename) as f :
    for line in f :
        line = line.rstrip("\n")
        m = re.match('([a-z\-]+)-(\d+)\[([^]]+)', line)
        (name, sector, checksum) = m.group(1, 2, 3)
        if real_room(name, checksum) :
            total = total + int(sector)
            decoded = decode(name, sector)
            print "%s => %s" % (decoded, line)

print total


