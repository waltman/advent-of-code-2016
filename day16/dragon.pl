#!/usr/bin/env perl
use strict;
use warnings;
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

my ($init, $len) = @ARGV;

my $data = dragon($init, $len);
my $sum = checksum($data);
say $sum;

sub dragon($s, $len) {
    while (length($s) < $len) {
        $b = reverse($s);
        $b =~ tr/01/10/;
        $s = $s . '0' . $b;
    }

    return substr($s, 0, $len);
}

sub checksum($sum) {
    my %h = ( '00' => '1',
              '01' => '0',
              '10' => '0',
              '11' => '1');

    while (length($sum) % 2 == 0) {
        $sum =~ s/(..)/$h{$1}/eg;
    }
    return $sum;
}
