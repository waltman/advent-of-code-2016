#!/usr/bin/env perl
use strict;
use warnings;
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

my @cmd;

while (<>) {
    chomp;
    push @cmd, $_;
}

my @program = map { parse($_) } @cmd;

my $n = 0;
my $init_a = 0;

while (1) {
    my $ip = 0;
    $init_a++;
    say "trying $init_a" if ($init_a % 100) == 0;

    my %reg = ( a => $init_a,
                b => 0,
                c => 0,
                d => 0,
                bit => 0,
                cnt => 0,
                ok => 0);

    while ($ip >= 0 && $ip < @program) {
        $n++;
#        say commify($n) if ($n % 10_000_000) == 0;
        $ip = $program[$ip]->($ip, \%reg);
    }

    if ($reg{ok}) {
        say "works when a = $init_a";
        say "";
        say "$n:";
        for my $k ('a'..'d', qw(bit cnt ok)) {
            say "$k = $reg{$k}";
        }

        last;
    }
}



sub parse($cmd) {
    my @tok = split / /, $cmd;

    if ($tok[0] eq "cpy") {
        if ($tok[1] =~ /^[a-d]$/) {
            return sub($ip, $reg) {
                $reg->{$tok[2]} = $reg->{$tok[1]} if $tok[2] =~ /^[a-d]$/;
                return $ip + 1;
            }
        } else {
            return sub($ip, $reg) {
                $reg->{$tok[2]} = $tok[1] if $tok[2] =~ /^[a-d]$/;
                return $ip + 1;
            }
        } 
    } elsif ($tok[0] eq "inc") {
        return sub($ip, $reg) {
            $reg->{$tok[1]}++;
            return $ip + 1;
        }
    } elsif ($tok[0] eq "dec") {
        return sub($ip, $reg) {
            $reg->{$tok[1]}--;
            return $ip + 1;
        }
    } elsif ($tok[0] eq "out") {
        return sub($ip, $reg) {
            my $next = $reg->{$tok[1]};
            if ($next != $reg->{bit}) {
                return @program;
            } else {
                $reg->{bit} = ($reg->{bit} + 1) % 2;
                $reg->{cnt}++;
                if ($reg->{cnt} > 1000) {
                    $reg->{ok} = 1;
                    return @program;
                }
            }
            return $ip + 1;
        }
    } elsif ($tok[0] eq "jnz") {
        return sub($ip, $reg) {
            if ($tok[1] =~ /^[a-d]$/) {
                if ($reg->{$tok[1]} != 0) {
                    if ($tok[2] =~ /^[a-d]$/) {
                        return $ip + $reg->{$tok[2]};
                    } else {
                        return $ip + $tok[2];
                    }
                } else {
                    return $ip + 1;
                }
            } elsif ($tok[1] != 0) {
                if ($tok[2] =~ /^[a-d]$/) {
                    return $ip + $reg->{$tok[2]};
                } else {
                    return $ip + $tok[2];
                }
            } else {
                return $ip + 1;
            }
        }
    } elsif ($tok[0] eq 'tgl') {
        return sub($ip, $reg) {
            my $offset = $ip + $reg->{$tok[1]};
            if ($offset >= 0 && $offset <= $#cmd) {
                my $old_cmd = $cmd[$offset];
                my @tok = split / /, $old_cmd;
                if ($tok[0] eq 'inc') {
                    $tok[0] = 'dec';
                } elsif ($tok[0] eq 'dec' || $tok[0] eq 'tgl') {
                    $tok[0] = 'inc';
                } elsif ($tok[0] eq 'jnz') {
                    $tok[0] = 'cpy';
                } elsif ($tok[0] eq 'cpy') {
                    $tok[0] = 'jnz';
                }
                my $new_cmd = join ' ', @tok;
                say "toggle $old_cmd to $new_cmd";
                $cmd[$offset] = $new_cmd;
                $program[$offset] = parse($new_cmd);
            }
            return $ip + 1;
        }
    }
}

sub commify {
    local $_  = shift;
    1 while s/^([-+]?\d+)(\d{3})/$1,$2/;
    return $_;
}
