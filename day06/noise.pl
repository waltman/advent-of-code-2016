#!/usr/bin/env perl
use strict;
use warnings;
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

my @used;

while (<>) {
    chomp;
    my @s = split //;
    for my $i (0..$#s) {
        $used[$i]->{$s[$i]}++;
    }
}

my $s;
my $t;

for my $h (@used) {
    my @k = sort {$h->{$b} <=> $h->{$a}} keys %$h;
    $s .= $k[0];
    $t .= $k[-1];
}

say $s;
say $t;
