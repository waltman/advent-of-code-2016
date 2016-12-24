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
my %skip;

my $i = -1;
my $n = 0;
while ($n < $num_elves - 1) {
    # find elf to get gifts
    do {
        $i = ($i + 1) % $num_elves;
    } while (defined $skip{$i});

    # fine elf to give gifts
    my $j = $i;
    do {
        $j = ($j + 1) % $num_elves;
    } while (defined $skip{$j});
#    say "elf $elves[$i] gets gifts from elf $elves[$j]";
    $skip{$j} = 1;
    $n++;
#    say "n = $n";
}

say $elves[$i];
