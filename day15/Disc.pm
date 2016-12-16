package Disc;

use strict;
use warnings;
use 5.24.0;
use Moose;
use feature 'signatures';
no warnings "experimental::signatures";

has 'num' => (is => 'ro');
has 'start' => (is => 'ro');

__PACKAGE__->meta->make_immutable;

1;
