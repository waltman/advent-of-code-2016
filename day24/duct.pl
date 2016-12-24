#!/usr/bin/env perl
use strict;
use warnings;
use 5.24.0;
use Graph;
use Algorithm::Combinatorics qw(permutations);
use feature 'signatures';
no warnings "experimental::signatures";

my @maze;
my $num_rows;
my $num_cols;

say "parsing input";
while (<>) {
    chomp;
    my @c = split //;
    push @maze, \@c;
    $num_cols = @c;
    $num_rows++;
}

my @loc;
my %open;

for my $row (0..$num_rows-1) {
    for my $col (0..$num_cols-1) {
        my $p = $maze[$row][$col];
        $open{"$row,$col"} = 1 unless $p eq '#';
        $loc[$p] = "($row $col)" if $p =~ /\d/;
    }
}

say "making graph";
my $g = make_graph(\%open);

say "finding shortest paths";
my @sp;
for my $i (0..$#loc-1) {
    for my $j ($i+1..$#loc) {
        my @path = $g->SP_Dijkstra($loc[$i], $loc[$j]);
        my $len = @path - 1;
        $sp[$i][$j] = $len;
        $sp[$j][$i] = $len;
    }
}

say "checking permutations";
my $shortest = 1e300;
my $iter = permutations([1..$#loc]);
while (my $p = $iter->next) {
    unshift @$p, 0;
    push @$p, 0; # for part 2
    my $len = 0;
    for my $i (0..$#$p - 1) {
        $len += $sp[$p->[$i]][$p->[$i+1]];
    }
    if ($len < $shortest) {
        say "path @$p has length $len";
        $shortest = $len;
    }
}
say $shortest;

sub make_graph($open) {
    my @k = keys %$open;
    my $g = Graph::Undirected->new;

    for my $i (0..$#k-1) {
        my ($row1, $col1) = split ',', $k[$i];
        for my $j ($i+1..$#k) {
            my ($row2, $col2) = split ',', $k[$j];
            if ((abs($row1-$row2) == 1 && $col1==$col2) || ($row1==$row2) && abs($col1-$col2) == 1) {
                $g->add_edge("($row1 $col1)", "($row2 $col2)");
            }
        }
    }
    return $g;
}
