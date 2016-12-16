#!/usr/bin/env perl
use strict;
use warnings;
use 5.24.0;
use Disc;
use feature 'signatures';
no warnings "experimental::signatures";

my @disc;

while (<>) {
    chomp;
    my @tok = split;
    my $num = $tok[3];
    my $start = $tok[-1];
    chop $start;
    push @disc, Disc->new(num => $num, start => $start);
}

my $t = 0;
while (1) {
    say "t = $t" if $t % 100_000 == 0;

    my $ok = 1;
    for my $i (0..$#disc) {
        my $disc = $disc[$i];
        if (($disc->start + $t + $i + 1) % $disc->num) {
            $ok = 0;
            last;
        }
    }

    if ($ok) {
        say $t;
        last;
    } else {
        $t++;
    }
}
