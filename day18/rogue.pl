#!/usr/bin/env perl
use strict;
use warnings;
use Digest::MD5 qw(md5_hex);
use Memoize;
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

my ($rows, $input) = @ARGV;

my @rows = ($input);

for my $i (1..$rows-1) {
    $rows[$i] = next_row($rows[$i-1]);
}

# for my $i (0..$#rows) {
#     say $rows[$i];
# }

say num_safe(\@rows);

sub next_row ($row) {
    my %next_tile = ('...' => '.',
                     '..^' => '^',
                     '.^.' => '.',
                     '.^^' => '^',
                     '^..' => '^',
                     '^.^' => '.',
                     '^^.' => '^',
                     '^^^' => '.',
                    );

    my $next_row = '';
    my $s = '.' . $row . '.';
    for my $i (1..length($s)-2) {
        $next_row .= $next_tile{substr($s, $i-1, 3)};
    }

    return $next_row;
}

sub num_safe($rows) {
    my $n = 0;
    for my $row (@$rows) {
        $n += ($row =~ tr/.//);
    }

    return $n;
}
