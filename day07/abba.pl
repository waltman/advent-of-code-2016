#!/usr/bin/env perl
use strict;
use warnings;
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

my $n = 0;

while (<>) {
    chomp;
    my $orig = $_;

    # assume [ and ] come in pairs and aren't nested
#    $_ = "x$_" if substr($_, 0, 1) eq "[";
    s/[\[\]]/ /g;
    my @s = split / /;

    my @have_abba;
    for my $i (0..$#s) {
        $have_abba[$i % 2]++ if has_abba($s[$i]);
    }

    if ($have_abba[0] && !$have_abba[1]) {
        say "GOOD => $orig";
        $n++;
    } else {
        say "BAD  => $orig";
    }
}

say $n;

sub has_abba($s) {
    my @c = split //, $s;

    for my $i (0..$#c - 3) {
        if ($c[$i] eq $c[$i+3] && $c[$i+1] eq $c[$i+2] && $c[$i] ne $c[$i+1]) {
#            say "$s has abba";
            return 1;
        }
    }
#    say "$s doesn't have abba";
    return 0;
}
