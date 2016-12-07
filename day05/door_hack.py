#!/usr/bin/env python
from sys import argv
import hashlib

script, door_id = argv
password = ''
i = 0

while len(password) < 8 :
    k = "%s%i" % (door_id, i)
    m = hashlib.md5(k)
    hash = m.hexdigest()
    if hash[0:5] == "00000" :
        password = password + hash[5]
        print password
    i = i + 1

print password
