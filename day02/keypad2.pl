#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(min max);
use 5.24.0;

my $keypad = [
              [undef, undef, undef, undef, undef, undef, undef],
              [undef, undef, undef,     1, undef, undef, undef],
              [undef, undef,     2,     3,     4, undef, undef],
              [undef,     5,     6,     7,     8,     9, undef],
              [undef, undef,   'A',   'B',   'C', undef, undef],
              [undef, undef, undef,   'D', undef, undef, undef],
              [undef, undef, undef, undef, undef, undef, undef],
             ];

my ($y, $x) = (3, 1);
my @code;

while (<>) {
    chomp;
    my @moves = split //;
    for my $move (@moves) {
        if ($move eq 'U' && defined $keypad->[$y-1][$x]) {
            $y--;
        }
        if ($move eq 'D' && defined $keypad->[$y+1][$x]) {
            $y++;
        }
        if ($move eq 'L' && defined $keypad->[$y][$x-1]) {
            $x--;
        }
        if ($move eq 'R' && defined $keypad->[$y][$x+1]) {
            $x++;
        }
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

