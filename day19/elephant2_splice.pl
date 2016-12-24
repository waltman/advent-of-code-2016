#!/usr/bin/env perl
use strict;
use warnings;
use Digest::MD5 qw(md5_hex);
use Memoize;
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

my ($num_elves) = @ARGV;

my @elves = map { $_ } 1..$num_elves;

my $i = 0;
while (@elves > 1) {
    say scalar @elves if (@elves % 10000) == 0;

    my $j = int(($i + @elves / 2)) % @elves;
    say "$elves[$i] <- $elves[$j] ($i, $j, $#elves)";
    splice @elves, $j, 1;
#    $i = ($i >= $#elves) ? 0 : ($i + 1) % @elves;
    if ($i < $j) {
        $i = ($i + 1) % @elves;
    } elsif ($i > $#elves) {
        $i = 0;
    }
}

say @elves;
