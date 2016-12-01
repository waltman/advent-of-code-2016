#!/usr/bin/env perl
use strict;
use warnings;
use 5.24.0;

my %dirv = (N => [0,1],
            S => [0,-1],
            E => [1,0],
            W => [-1,0]
           );

my %r = (N => 'E',
         E => 'S',
         S => 'W',
         W => 'N'
        );

my %l = (N => 'W',
         E => 'N',
         S => 'E',
         W => 'S'
        );

my @pos = (0, 0);
my $dir = 'N';

while (<>) {
    chomp;
    my @moves = split /, /;
    for my $move (@moves) {
        my $turn = substr($move, 0, 1);
        my $n = substr($move, 1);

        if ($turn eq 'R') {
            $dir = $r{$dir};
        } else {
            $dir = $l{$dir};
        }
        my $dirv = $dirv{$dir};

        $pos[0] += $dirv->[0] * $n;
        $pos[1] += $dirv->[1] * $n;
    }
}

say "@pos";
say abs($pos[0]) + abs($pos[1]);
