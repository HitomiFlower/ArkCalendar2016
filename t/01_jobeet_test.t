#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 1;

use Jobeet::Models;
use Jobeet::Test;

like models('conf')->{database}[0], qr{dbi:SQLite:/.+jobeet-test-database\.db}, 'connect mock database after "use Jobeet::Test"';


