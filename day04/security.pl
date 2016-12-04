#!/usr/bin/env perl
use strict;
use warnings;
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

my $sum = 0;

while (<>) {
    chomp;
    m/([a-z\-]+)-(\d+)\[([^]]+)/;
    my ($name, $sector, $checksum) = ($1, $2, $3);
    if (real_room($name, $checksum)) {
        $sum += $sector;
        my $decoded = decode($name, $sector);
        say "$decoded => $_";
    }
}

say $sum;

sub real_room($name, $checksum) {
    my %cnt;

    $name =~ s/-//g;
    $cnt{$_}++ for split //, $name;

    my @s = sort {$cnt{$b} <=> $cnt{$a} || $a cmp $b} keys %cnt;
    if (@s < 5) {
        return 0;
    } else {
        return $checksum eq join "", @s[0..4];
    }
}

sub decode($name, $sector) {
    my @decoded = map { rotate($_, $sector) } split //, $name;
    return join "", @decoded;
}

sub rotate($s, $cnt) {
    if ($s eq '-') {
        return ' ';
    } else {
        my $n = ord($s) - ord('a') + $cnt;
        $n %= 26;
        return chr($n + ord('a'));
    }
}
