#!/usr/bin/env perl
use strict;
use warnings;
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

my @data;

while (<>) {
    next unless $. > 2;
    chomp;
    my @tok = split /\s+/;
    my ($used, $avail) = @tok[2,3];
    die "$_\n" if substr($used, -1) ne 'T';
    die "$_\n" if substr($avail, -1) ne 'T';
    chop $used;
    chop $avail;
    push @data, [$used, $avail];
}

my $cnt = 0;
for my $i (0..$#data) {
    my ($u1, $a1) = @{$data[$i]};
    next if $u1 == 0;
    for my $j (0..$#data) {
        next if $i == $j;
        my ($u2, $a2) = @{$data[$j]};
        $cnt++ if $u1 <= $a2;
    }
}

say $cnt;
