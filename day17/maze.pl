#!/usr/bin/env perl
use strict;
use warnings;
use Digest::MD5 qw(md5_hex);
use Memoize;
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

my $input = $ARGV[0];

my @q = [1, 1, $input];
my $n = 0;

while (@q) {
    $n++;
    say "n = $n";
    my ($row, $col, $passcode) = @{shift @q};
    if ($row == 4 && $col == 4) {
        say "finished with passcode ", substr($passcode,length $input);
        last;
    } elsif ($row < 1 || $row > 4 || $col < 0 || $col > 4) {
        next;
    } else {
        my $hash = md5_hex($passcode);
        if (substr($hash, 0, 1) =~ /[b-f]/) {
            push @q, [$row-1, $col, $passcode . 'U'];
        }
        if (substr($hash, 1, 1) =~ /[b-f]/) {
            push @q, [$row+1, $col, $passcode . 'D'];
        }
        if (substr($hash, 2, 1) =~ /[b-f]/) {
            push @q, [$row, $col-1, $passcode . 'L'];
        }
        if (substr($hash, 3, 1) =~ /[b-f]/) {
            push @q, [$row, $col+1, $passcode . 'R'];
        }
    }
}

say "failed" unless @q;
