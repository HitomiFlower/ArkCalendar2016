#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use v5.16.3;
use lib qw(. ./lib);

use Jobeet::Schema;
my $schema = Jobeet::Schema->connect('dbi:SQLite:./test.db');

my $category_rs = $schema->resultset('Category');
my $category = $category_rs->update({
    name => 'new category_2',
});
my $new_rs = $category_rs->search({ name => 'new category_2' });
print $category_rs->count;
while (my $set = $new_rs->next) {
    print $set->name;
}
$category->delete;