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
    say decomp_len2($line);
}

sub commify {
    local $_  = shift;
    1 while s/^([-+]?\d+)(\d{3})/$1,$2/;
    return $_;
}

sub decomp_len($s) {
    if ($s =~ $regex) {
        my $expand = substr($', 0, $1) x $2;
        my $rest = substr($', $1);
#        say "s = $s, expand = $expand, rest = $rest";
        return length($`) + decomp_len($expand) + decomp_len($rest);
    } else {
        return length($s);
    }
}

sub decomp_len2($s) {
    my @q = ($s);
    my $n = 0;
    my $i = 0;

#    while ($s = shift @q) {
    while ($s = pop @q) {
        $i++;
        if ($i % 100000 == 0) {
            say commify($i), ", ", commify($n), ", ", commify(scalar(@q));
        }

        if ($s =~ $regex) {
            $n += length($`);
            my $expand = substr($', 0, $1) x $2;
            my $rest = substr($', $1);
            push @q, $expand;
            push @q, $rest if $rest;
        } else {
            $n += length($s);
        }
    }

    return $n;
}
