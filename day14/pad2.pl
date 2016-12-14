#!/usr/bin/env perl
use strict;
use warnings;
use Digest::MD5 qw(md5_hex);
use Memoize;
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

my $salt = $ARGV[0];

my $n = 0;
my $i = -1;
memoize('md5_2016');

while ($n < 64) {
    $i++;
    say $i if $i % 1000 == 0;
    my $hash = md5_hex($salt . $i);
    $hash = md5_2016($hash);
    if ($hash =~ /(.)\1{2}/) {
        my $rep = $1;
        for my $j ($i+1..$i+1000) {
            $hash = md5_hex($salt . $j);
            $hash = md5_2016($hash);
            if ($hash =~ /$rep{5}/) {
                $n++;
                say "found key $n with i=$i";
                last;
            }
        }
    }
}

say $i;

sub md5_2016($s) {
    $s = md5_hex($s) for 1..2016;
    return $s;
}
