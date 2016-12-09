#!/usr/bin/env perl
use strict;
use warnings;
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

# $/ = "";
while (my $line = <>) {
    chomp $line;
#    s/\s//g;
    say $line;
    my $out = "";
    while (1) {
        if ($line =~ /(.*?)\((\d+)x(\d+)\)(.*)/) {
            $out .= $1;
            $out .= substr($4, 0, $2) x $3;
            $line = substr($4, $2);
        } else {
            $out .= $line;
            last;
        }
    }
    say $out;
    say length $out;
}
