#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(min max);
use 5.24.0;

my $keypad = [
              [1, 2, 3],
              [4, 5, 6],
              [7, 8, 9]
             ];

my ($x, $y) = (1, 1);
my @code;

while (<>) {
    chomp;
    my @moves = split //;
    for my $move (@moves) {
        $y = max($y-1, 0) if $move eq 'U';
        $y = min($y+1, 2) if $move eq 'D';
        $x = max($x-1, 0) if $move eq 'L';
        $x = min($x+1, 2) if $move eq 'R';
#        say "$move $x $y $keypad->[$y][$x]";
    }
#    say "adding $keypad->[$y][$x]";
    push @code, $keypad->[$y][$x];
}

say join "", @code;
# say scalar @code;
# for my $i (0..$#code) {
#     say "$i $code[$i]";
# }

