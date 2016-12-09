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
#    my $out = "";
    my $out_len = 0;
    my $n = 0;
    while (1) {
        $n++;
        if ($n % 10000 == 0) {
            say commify($n), ", ", commify($out_len), ", ", commify(length($line));
        }

        if ($line =~ /(.*?)\((\d+)x(\d+)\)(.*)/) {
#            $out .= $1;
            $out_len += length($1);
#            $out .= substr($4, 0, $2) x $3;
            $line = substr($4, 0, $2) x $3 . substr($4, $2);
        } else {
#            $out .= $line;
            $out_len += length($line);
            last;
        }
    }
#    say $out;
#    say length $out;
    say $out_len;
    say $n;
}

sub commify {
    local $_  = shift;
    1 while s/^([-+]?\d+)(\d{3})/$1,$2/;
    return $_;
}
