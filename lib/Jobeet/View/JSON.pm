package Jobeet::View::JSON;
use strict;
use warnings FATAL => 'all';
use Ark 'View::JSON';

has '+expose_stash' => (
    default => 'json',
);

1;