#!/usr/bin/env perl
use strict;
use warnings;
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

my $start = shift;
my @program;
my @cmd;

while (<>) {
    chomp;
    push @cmd, $_;

    my @tok = split / /;
    if ($tok[0] eq 'swap' && $tok[1] eq 'position') {
        push @program, sub($s) {
            my $p1 = $tok[2];
            my $p2 = $tok[5];
            my $tmp = substr($s, $p1, 1);
            substr($s, $p1, 1) = substr($s, $p2, 1);
            substr($s, $p2, 1) = $tmp;
            return $s;
        }
    } elsif ($tok[0] eq 'swap' && $tok[1] eq 'letter') {
        push @program, sub($s) {
            my $l1 = $tok[2];
            my $l2 = $tok[5];
            my @s = split //, $s;
            my ($p1, $p2);
            for my $i (0..$#s) {
                $p1 = $i if $s[$i] eq $l1;
                $p2 = $i if $s[$i] eq $l2;
            }
            @s[$p1,$p2] = @s[$p2,$p1];
            return join "", @s;
        }
    } elsif ($tok[0] eq 'reverse') {
        push @program, sub($s) {
            my $p1 = $tok[2];
            my $p2 = $tok[4];
            my $len = $p2-$p1+1;
            substr($s, $p1, $len) = reverse(substr($s, $p1, $len));
            return $s;
        }
    } elsif ($tok[0] eq 'rotate' and $tok[1] eq 'right') {
        push @program, sub($s) {
            my $len = $tok[2];
            return substr($s, $len) . substr($s, 0, $len);
        }
    } elsif ($tok[0] eq 'rotate' and $tok[1] eq 'left') {
        push @program, sub($s) {
            my $len = $tok[2];
            $s = substr($s, -1) . substr($s, 0, -1) for (1..$len);
            return $s;
        }
    } elsif ($tok[0] eq 'move') {
        push @program, sub($s) {
            my $p2 = $tok[2];
            my $p1 = $tok[5];
            my $c = substr($s, $p1, 1);
            substr($s, $p1, 1) = "";
            my $t = substr($s, 0, $p2) . $c . substr($s, $p2);
            return $t;
        }
    } elsif ($tok[0] eq 'rotate' and $tok[1] eq 'based') {
        push @program, sub($s) {
            my $c = $tok[-1];
            my $t = $s;

            my @match;
            for (1..length($s)) {
                push @match, $s if rotate_based($s, $c) eq $t;
#                $s = substr($s, -1) . substr($s, 0, -1);
                $s = substr($s, 1) . substr($s, 0, 1);
            }
            say "matching: @match";
            return $match[0];
        }
    }
}

my $s = $start;
for (my $i = $#cmd; $i >= 0; $i--) {
    say $cmd[$i];
    my $t = $program[$i]->($s);
    say "$s => $t";
    $s = $t;
    last if length($t) < length($start);
}
say $s;

sub rotate_based($s, $c) {
    my @s = split //, $s;
    my $pos;
    for my $i (0..$#s) {
        if ($s[$i] eq $c) {
            $pos = $i;
            last;
        }
    }
    my $n = ($pos < 4) ? $pos + 1 : $pos + 2;
    for (1..$n) {
        $s = substr($s, -1) . substr($s, 0, -1);
    }
    return $s;
}
