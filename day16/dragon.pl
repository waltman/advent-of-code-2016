#!/usr/bin/env perl
use strict;
use warnings;
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

my ($init, $len) = @ARGV;

my $data = dragon($init, $len);
#say $data;
my $sum = checksum($data);
say $sum;

sub dragon($s, $len) {
    while (length($s) < $len) {
        $b = reverse($s);
        $b =~ s/0/2/g;
        $b =~ s/1/0/g;
        $b =~ s/2/1/g;
        $s = $s . '0' . $b;
        # say "s = $s";
    }

    return substr($s, 0, $len);
}

sub checksum($data) {
    my $sum = $data;
    while (length($sum) % 2 == 0) {
        # say "sum = $sum";
        # say "length = " . length($sum);
        my $tmp;
        for (my $i = 0; $i < length($sum); $i += 2) {
            my $c1 = substr($sum, $i, 1);
            my $c2 = substr($sum, $i+1, 1);
            $tmp .= $c1 == $c2 ? 1 : 0;
        }
        $sum = $tmp;
    }
    return $sum;
}
