#!/usr/bin/env perl
use strict;
use warnings;
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

my @program;
my @cmd;

while (<>) {
    chomp;
    push @cmd, $_;

    my @tok = split / /;
    if ($tok[0] eq "cpy") {
        if ($tok[1] =~ /^[a-d]$/) {
            push @program, sub($ip, $reg) {
                $reg->{$tok[2]} = $reg->{$tok[1]};
                return $ip + 1;
            }
        } else {
            push @program, sub($ip, $reg) {
                $reg->{$tok[2]} = $tok[1];
                return $ip + 1;
            }
        } 
    } elsif ($tok[0] eq "inc") {
        push @program, sub($ip, $reg) {
            $reg->{$tok[1]}++;
            return $ip + 1;
        }
    } elsif ($tok[0] eq "dec") {
        push @program, sub($ip, $reg) {
            $reg->{$tok[1]}--;
            return $ip + 1;
        }
    } elsif ($tok[0] eq "jnz") {
        push @program, sub($ip, $reg) {
            if ($tok[1] =~ /^[a-d]$/) {
                if ($reg->{$tok[1]} != 0) {
                    return $ip + $tok[2];
                } else {
                    return $ip + 1;
                }
            } elsif ($tok[1] != 0) {
                return $ip + $tok[2];
            } else {
                return $ip + 1;
            }
        }
    }
}

my $ip = 0;
my $n = 0;

my %reg = ( a => 0,
            b => 0,
            c => 1,
            d => 0);

while ($ip >= 0 && $ip < @program) {
    $n++;
    # say "$n: $cmd[$ip]";
    # for my $k ('a'..'d') {
    #     say "$k = $reg{$k}";
    # }
    # say "";
    $ip = $program[$ip]->($ip, \%reg);
}

say "$n:";
for my $k ('a'..'d') {
    say "$k = $reg{$k}";
}
