#!/usr/bin/env perl
use strict;
use warnings;
use Digest::MD5 qw(md5_hex);
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

my $door_id = $ARGV[0];
my $password = ' ' x 8;
my $i = 0;
my $n = 0;

while ($n < 8) {
    my $hash = md5_hex($door_id . $i);
    if (substr($hash, 0, 5) eq '0' x 5) {
        my $pos = substr($hash, 5, 1);
        my $val = substr($hash, 6, 1);
        if ($pos =~ /[0-7]/ && substr($password, $pos, 1) eq ' ') {
            substr($password, $pos, 1) = $val;
            say $password;
            $n++;
        }
    }
    $i++;
}

say $password;
