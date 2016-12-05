#!/usr/bin/env perl
use strict;
use warnings;
use Digest::MD5 qw(md5_hex);
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

my $door_id = $ARGV[0];
my $password = '';
my $i = 0;

while (length($password) < 8) {
    my $hash = md5_hex($door_id . $i);
    if (substr($hash, 0, 5) eq '00000') {
        $password .= substr($hash, 5, 1);
        say $password;
    }
    $i++;
}

say $password;
