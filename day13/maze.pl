#!/usr/bin/env perl
use strict;
use warnings;
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

my ($endx, $endy, $favorite) = @ARGV;

# show_maze(10, 10, $favorite);

my %seen;
my @q = [1,1,0];
my $n = 0;

while (@q) {
    my ($x, $y, $step) = @{shift @q};

    $n++;
    say "$n iterations" if $n % 10 == 0;

    if ($x == $endx && $y == $endy) {
        say "finished in $step steps and $n iterations!";
        last;
    } elsif ($x < 0 || $y <0) {
        next;
    } elsif (is_wall($x, $y, $favorite)) {
        next;
    } elsif (defined $seen{"$x $y"}) {
        next;
    } else {
        $seen{"$x $y"} = 1;
        push @q, [$x-1, $y, $step+1];
        push @q, [$x+1, $y, $step+1];
        push @q, [$x, $y-1, $step+1];
        push @q, [$x, $y+1, $step+1];
    }
}

say "failed";

sub is_wall($x, $y, $favorite) {
    my $val = $x*$x + 3*$x + 2*$x*$y + $y + $y*$y + $favorite;
    my $bin = sprintf '%b', $val;
    my $count = ($bin =~ tr/1//);
    return $count % 2;
}

sub show_maze($width, $height, $favorite) {
    print "  ";
    print $_ % 10 for 0..$width-1;
    print "\n";

    for my $y (0..$height-1) {
        print $y % 10, ' ';
        for my $x (0..$width-1) {
            print is_wall($x, $y, $favorite) ? '#' : '.';
        }
        print "\n";
    }
}
