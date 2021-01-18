#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use v5.16.3;
use lib qw(. ./lib);

use Jobeet::Models;
my $json_string1 = '{"name": "Manager"}';

# use Jobeet::Schema;
# my $schema = Jobeet::Schema->connect('dbi:SQLite:./test.db');
# my $category_rs = $schema->resultset('Category');
# my $category = $category_rs->search({
#     name => $json_string1,
# });
# $category->delete;
#
# my $data = models('Schema::Category')->create({
#     name => $json_string1,
# });
#
# say $data->name->{position};

my $json = { name => 'Tester' };

my $data2 = models('Schema::Category')->create({
    name => $json,
});

say $data2->name->{foo};