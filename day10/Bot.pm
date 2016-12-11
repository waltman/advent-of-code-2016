package Bot;

use strict;
use warnings;
use Carp;
use 5.24.0;
use feature 'signatures';
no warnings "experimental::signatures";

sub new($package, $num) {
    my $self = {};
    bless $self, $package;

    $self->_init($num);

    return $self;
}

sub _init($self, $num) {
    $self->{num} = $num;
    $self->{vals} = [];
    $self->{low} = undef;
    $self->{low_dest} = undef;
    $self->{high} = undef;
    $self->{high_dest} = undef;
}

sub dump($self) {
    printf "num = %d, low = %d, low_dest = %s, high = %d, high_dest = %s, vals = %s\n",
        $self->num,
        $self->low, $self->low_dest,
        $self->high, $self->high_dest,
        "@{$self->{vals}}";
}

sub add($self, $val) {
    if (!$self->isfull && $self->{vals}->[0] != $val) {
        push @{$self->{vals}}, $val;
    }
}

sub isfull($self) {
    return @{$self->{vals}} == 2;
}

sub num($self) {
    return $self->{num};
}

sub low($self) {
    return $self->{low};
}

sub low_dest($self) {
    return $self->{low_dest};
}

sub high($self) {
    return $self->{high};
}

sub high_dest($self) {
    return $self->{high_dest};
}

sub vals($self) {
    if (!$self->isfull) {
        croak "bot $self->{num} isn't full";
    } else {
        my @vals = sort {$a <=> $b} @{$self->{vals}};
        return @vals;
    }
}

sub gives($self, $low, $low_dest, $high, $high_dest) {
    $self->{low} = $low;
    $self->{low_dest} = $low_dest;
    $self->{high} = $high;
    $self->{high_dest} = $high_dest;
}

1;
