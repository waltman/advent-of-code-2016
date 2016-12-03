#!/usr/bin/env perl
use strict;
use warnings;
use 5.24.0;

my $num_good = 0;
while (<>) {
    chomp;
    s/^\s+//;
    my @s = split /\s+/;
    my $bad = 0;
    for my $i (0..1) {
        for my $j ($i+1..2) {
            if ($s[$i] + $s[$j] <= $s[3-$i-$j]) {
                $bad = 1;
                last;
            }
        }
    }
    $num_good++ unless $bad;
}

say $num_good;
