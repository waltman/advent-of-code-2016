#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(first);
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

# my $MAX = 9;
my $MAX = 4294967295;

my @range;

while (<>) {
    chomp;
    my ($from, $to) = split /\-/;
    push @range, [$from, $to];
}

for my $i (0..$MAX) {
    if ($i % 100_000 == 0) {
        printf "i = %s (%.2f%%)\n", commify($i), $i*100/$MAX;
    }
    my $ok = 1;
    for my $j (0..$#range) {
        if ($i >= $range[$j]->[0] && $i <= $range[$j]->[1]) {
            $ok = 0;
            last;
        }
    }
    if ($ok) {
        say $i;
        last;
    }
}

sub commify {
    local $_  = shift;
    1 while s/^([-+]?\d+)(\d{3})/$1,$2/;
    return $_;
}
