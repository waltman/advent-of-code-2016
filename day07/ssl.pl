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
    say $orig;

    # assume [ and ] come in pairs and aren't nested
#    $_ = "x$_" if substr($_, 0, 1) eq "[";
    s/[\[\]]/ /g;
    my @s = split / /;

    my @aba;
    my @bab;
    for my $i (0..$#s) {
        if ($i % 2 == 0) {
            push @aba, @{find_aba($s[$i])};
        } else {
            push @bab, @{find_aba($s[$i])};
        }
    }

    if (has_ssl(\@aba, \@bab)) {
        say "GOOD => $orig";
        $n++;
    } else {
        say "BAD  => $orig";
    }


}

say $n;

sub find_aba($s) {
    my @c = split //, $s;
    my @a;

    for my $i (0..$#c - 2) {
        if ($c[$i] eq $c[$i+2] && $c[$i] ne $c[$i+1]) {
            push @a, substr($s, $i, 3);
        }
    }
    return \@a;
}

sub has_ssl($aba, $bab) {
    for my $s (@$aba) {
        my @c = split //, $s;
        my $rev = sprintf "^%s%s%s\$", $c[1], $c[0], $c[1];
        return 1 if grep /$rev/, @$bab;
    }

    return 0;
}
