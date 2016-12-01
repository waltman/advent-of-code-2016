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

my %visited;

my @pos = (0, 0);
my $dir = 'N';
my $done = 0;

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

        for my $j (0..$n-1) {
            $pos[0] += $dirv->[0];
            $pos[1] += $dirv->[1];

            if (++$visited{"@pos"} > 1) {
                say "visited (@pos) twice!";
                $done = 1;
                last;
            }
        }
        last if $done;
    }
}

if ($done) {
    say "@pos";
    say abs($pos[0]) + abs($pos[1]);
} else {
    say "Santa didn't visit any location twice.";
}

