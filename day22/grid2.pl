#!/usr/bin/env perl
use strict;
use warnings;
use 5.24.0;
use Graph;
use feature 'signatures';
no warnings "experimental::signatures";

my $maxx = -1;
my $maxy = -1;
my @node;
my @used;
my @avail;
my $x0;
my $y0;
my $a0;

while (<>) {
    next unless /^\//;
    chomp;
    my @tok = split /\s+/;
    my ($fs, $used, $avail) = @tok[0,2,3];
    chop $used;
    chop $avail;
    $fs =~ /x(\d+)-y(\d+)/;
    my $x = $1;
    my $y = $2;
    $maxx = $x if $x > $maxx;
    $maxy = $y if $y > $maxy;
    if ($used == 0) {
        ($x0, $y0, $a0) = ($x, $y, $avail);
    }
    $used[$x][$y] = $used;
    $avail[$x][$y] = $avail;
    push @node, [$x,$y];
}

# build graph
my $g = Graph->new;
for my $i (0..$#node) {
    my ($x1, $y1) = @{$node[$i]};
    for my $j (0..$#node) {
        next if $i == $j;
        my ($x2, $y2) = @{$node[$j]};
        next unless (abs($x1-$x2) == 1 && abs($y1-$y2) == 0) || (abs($x1-$x2) == 0 && abs($y1-$y2) == 1);
        $g->add_edge("(x$x1 y$y1)", "(x$x2 y$y2)");
    }
}

for my $x (0..$maxx) {
    for my $y (0..$maxy) {
        $g->delete_vertex("(x$x y$y)") if $used[$x][$y] > $a0;
    }
}

# compute shortest path from empty node to corner
$, = ", ";
# say $g;
my @sp = $g->SP_Bellman_Ford("(x$x0 y$y0)", "(x$maxx y0)");
say scalar @sp;
say "@sp\n";
my $p1 = @sp;

@sp = $g->SP_Bellman_Ford("(x$maxx y0)", "(x0 y0)");
say scalar @sp;
say "@sp";
my $p2 = @sp;

my $len = ($p1-1) + (($p2-2)*5);
say "len = $len";
