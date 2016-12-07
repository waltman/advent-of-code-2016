#!/usr/bin/env python
from sys import argv
import hashlib

script, door_id = argv
password = list('        ')
i = 0
n = 0

while n < 8 :
    k = "%s%i" % (door_id, i)
    m = hashlib.md5(k)
    hash = m.hexdigest()
    if hash[0:5] == "00000" :
        pos = hash[5]
        val = hash[6]
        if pos >= "0" and pos <= "7" and password[int(pos)] == " " :
            password[int(pos)] = val
            print "".join(password)
            n = n + 1
    i = i + 1

print "".join(password)
