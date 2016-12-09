#!/usr/bin/env perl
use strict;
use warnings;
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

# my $ROWS = 3;
# my $COLS = 7;
my $ROWS = 6;
my $COLS = 50;
my $screen = init($ROWS, $COLS);
print_screen($screen, $ROWS, $COLS);

while (<>) {
    print;
    chomp;
    my @tok = split ' ';
    if ($tok[0] eq 'rect') {
        do_rect($screen, \@tok);
    } elsif ($tok[0] eq 'rotate') {
        if ($tok[1] eq 'column') {
            do_rotate_col($screen, \@tok, $ROWS);
        } else {
            do_rotate_row($screen, \@tok, $COLS);
        }
    }
    print_screen($screen, $ROWS, $COLS);

}

say num_lit($screen, $ROWS, $COLS);

sub init($rows, $cols) {
    my @screen;

    push @screen, [map { ' ' } 1..$cols] for 1..$rows;

    return \@screen;
}

sub print_screen($screen, $rows, $cols) {
    for my $row (0..$rows-1) {
        for my $col (0..$cols-1) {
            print $screen->[$row][$col];
        }
        print "\n";
    }
    print "\n";
}

sub do_rect($screen, $tok) {
    my ($w, $h) = split 'x', $tok->[1];

    for my $row (0..$h-1) {
        for my $col (0..$w-1) {
            $screen->[$row][$col] = '#';
        }
    }
}

sub do_rotate_col($screen, $tok, $rows) {
    my (undef, $col) = split '=', $tok->[2];
    my $n = $tok->[4];

    for my $i (1..$n) {
        my $tmp = $screen->[$rows-1][$col];
        for (my $row = $rows-1; $row >= 1; $row--) {
            $screen->[$row][$col] = $screen->[$row-1][$col];
        }
        $screen->[0][$col] = $tmp;
    }
}

sub do_rotate_row($screen, $tok, $cols) {
    my (undef, $row) = split '=', $tok->[2];
    my $n = $tok->[4];

    for my $i (1..$n) {
        my $tmp = $screen->[$row][$cols-1];
        for (my $col = $cols-1; $col >= 1; $col--) {
            $screen->[$row][$col] = $screen->[$row][$col-1];
        }
        $screen->[$row][0] = $tmp;
    }
}

sub num_lit($screen, $rows, $cols) {
    my $n = 0;

    for my $row (0..$rows-1) {
        for my $col (0..$cols-1) {
            $n++ if $screen->[$row][$col] eq '#';
        }
    }

    return $n;
}
