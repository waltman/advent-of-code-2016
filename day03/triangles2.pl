#!/usr/bin/env perl
use strict;
use warnings;
use 5.24.0;

my $num_good = 0;
my (@c1, @c2, @c3);
while (<>) {
    chomp;
    s/^\s+//;
    my @s = split /\s+/;
    push @c1, $s[0];
    push @c2, $s[1];
    push @c3, $s[2];
}

my @input = (@c1, @c2, @c3);

for (my $k = 0; $k < @input; $k += 3) {
    my @s = @input[$k..$k+2];
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
