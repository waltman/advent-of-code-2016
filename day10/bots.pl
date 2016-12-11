#!/usr/bin/env perl
use strict;
use warnings;
use Bot;
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

my @bots;
my @outputs;

while (<>) {
    chomp;
    my @toks = split / /;
    if (@toks == 6) {
        # value
        my ($val, $to) = @toks[1,5];
        $bots[$to] //= Bot->new($to);
        $bots[$to]->add($val);
    } elsif (@toks == 12) {
        # gives
        my ($from, $low_dest, $low, $high_dest, $high) = @toks[1,5,6,10,11];
        $bots[$from] //= Bot->new($from) ;
        $bots[$low] //= Bot->new($low) if $low_dest eq "bot";
        $bots[$high] //= Bot->new($high) if $high_dest eq "bot";
        $bots[$from]->gives($low, $low_dest, $high, $high_dest);
    } else {
        say "bad input";
    }
}

say "initial";
for my $bot (@bots) {
    $bot->dump;
}

say "";

my $all_full;
my $i = 0;
do {
    $all_full = 1;
    for my $bot (@bots) {
        if ($bot->isfull) {
            my ($low_val, $high_val) = $bot->vals;
            if ($bot->low_dest eq "bot") {
                $bots[$bot->low]->add($low_val);
            } else {
                $outputs[$bot->low] = $low_val;
            }
            if ($bot->high_dest eq "bot") {
                $bots[$bot->high]->add($high_val);
            } else {
                $outputs[$bot->high] = $low_val;
            }
        } else {
            $all_full = 0;
        }
    }
    say "iteration ", ++$i;
    for my $bot (@bots) {
        $bot->dump;
    }
} while (!$all_full);

for my $i (0..$#outputs) {
    if (defined $outputs[$i]) {
        say "$i $outputs[$i]";
    } else {
        say "$i undef";
    }
}
