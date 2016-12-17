#!/usr/bin/env perl
use strict;
use warnings;
use Digest::MD5 qw(md5_hex);
use Memoize;
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

my $input = $ARGV[0];

my @q = [1, 1, ''];
my $n = 0;
my $longest = 0;

while (@q) {
    $n++;
    my ($row, $col, $path) = @{shift @q};
    if ($row == 4 && $col == 4) {
        if (length($path) > $longest) {
            $longest = length($path);
            say "longest = $longest, queue length = " . scalar @q;
        }
    } else {
        my $hash = md5_hex($input . $path);
        if ($row > 1 && substr($hash, 0, 1) =~ /[b-f]/) {
            push @q, [$row-1, $col, $path . 'U'];
        }
        if ($row < 4 && substr($hash, 1, 1) =~ /[b-f]/) {
            push @q, [$row+1, $col, $path . 'D'];
        }
        if ($col > 1 && substr($hash, 2, 1) =~ /[b-f]/) {
            push @q, [$row, $col-1, $path . 'L'];
        }
        if ($col < 4 && substr($hash, 3, 1) =~ /[b-f]/) {
            push @q, [$row, $col+1, $path . 'R'];
        }
    }
}

say $longest;
