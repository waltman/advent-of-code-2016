#!/usr/bin/env perl
use strict;
use warnings;
use Digest::MD5 qw(md5_hex);
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

my $salt = $ARGV[0];

my $n = 0;
my $i = -1;

while ($n < 64) {
    $i++;
    my $hash = md5_hex($salt . $i);
    if ($hash =~ /(.)\1{2}/) {
        my $rep = $1;
        for my $j ($i+1..$i+1000) {
            $hash = md5_hex($salt . $j);
            if ($hash =~ /$rep{5}/) {
                $n++;
                last;
            }
        }
    }
}

say $i;
