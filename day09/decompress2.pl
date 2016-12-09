#!/usr/bin/env perl
use strict;
use warnings;
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

my $regex = qr/\((\d+)x(\d+)\)/;

while (my $line = <>) {
    chomp $line;
    say $line;
    my $out_len = 0;
    my $n = 0;
    while (1) {
        $n++;
        if ($n % 100_000 == 0) {
            say commify($n), ", ", commify($out_len), ", ", commify(length($line));
        }

        if ($line =~ $regex) {
            $out_len += length($`);
            $line = substr($', 0, $1) x $2 . substr($', $1);
        } else {
            $out_len += length($line);
            last;
        }
    }
    say $out_len;
    say $n;
}

sub commify {
    local $_  = shift;
    1 while s/^([-+]?\d+)(\d{3})/$1,$2/;
    return $_;
}
