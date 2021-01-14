use strict;
use v5.16.3;
use warnings FATAL => 'all';
use utf8;
use lib qw(./lib ./local/lib);

use Jobeet::Schema;
my $schema = Jobeet::Schema->connect('dbi:SQLite:./test.db');
$schema->deploy;
