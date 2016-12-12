#!/usr/bin/env perl
use strict;
use warnings;
use Algorithm::Combinatorics qw(combinations);
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

# my $init_floors = "2131";
my $init_floors = "1211121111";
# my $init_floors = "12111211111111";
my $init_elevator = 1;
my @q = ([$init_elevator, $init_floors, 0]);
my $n = 0;
my %seen;

while (1) {
    my ($elevator, $floors, $steps) = @{shift @q};
    $n++;
    say "$n iterations" if $n % 100000 == 0;

    my $k = "$elevator$floors";
    if (defined($seen{$k})) {
        next;
    } else {
        $seen{$k} = 1;
    }

    if (finished($floors)) {
        say "finished in $steps steps and $n iterations";
        last;
    } elsif (!is_valid($floors)) {
        next;
    } else {
        my @floors = split //, $floors;
        my @on_floor;
        for my $i (0..$#floors) {
            push @on_floor, $i if $floors[$i] == $elevator;
        }
        next unless @on_floor;
        push @on_floor, -1;

        my $iter = combinations(\@on_floor, 2);
        while (my $p = $iter->next) {
            my @movers = ($p->[0]);
            push @movers, $p->[1] unless $p->[1] == -1;

            # up
            if ($elevator <= 3) {
                my $new_floors = $floors;
                for (@movers) {
                    substr($new_floors, $_, 1) = substr($new_floors, $_, 1) + 1;
                }
                push @q, [$elevator+1, $new_floors, $steps+1];
            }
            # down
            if ($elevator >= 2) {
                my $new_floors = $floors;
                for (@movers) {
                    substr($new_floors, $_, 1) = substr($new_floors, $_, 1) - 1;
                }
                push @q, [$elevator-1, $new_floors, $steps+1];
            }
        }
    }
}

sub is_valid($floors) {
    my @floors = split //, $floors;
    my %protected;

    for (my $i = 0; $i < @floors; $i += 2) {
        $protected{$i+1} = 1 if $floors[$i] == $floors[$i+1];
    }

    for (my $i = 0; $i < @floors; $i += 2) {
        for (my $j = 1; $j < @floors; $j += 2) {
            next if $protected{$j};
            if ($j != $i+1 && $floors[$i] == $floors[$j]) {
#                say "invalid!";
                return 0;
            }
        }
    }
#    say "valid";
    return 1;
}

sub finished($floors) {
    my @floors = split //, $floors;
    for my $f (@floors) {
        return 0 if $f != 4;
    }

    return 1;
}

