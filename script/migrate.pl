#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use utf8;
use lib 'lib';
use v5.16.3;

use Jobeet::Models;
use Getopt::Long;
use GitDDL;

GetOptions(
    \my %options,
    qw/dry-run/
);

my $dsn = models('conf')->{database}->[0];
my $gd = GitDDL->new(
    work_tree => './',
    ddl_file  => './sql/schema.sql',
    dsn       => models('conf')->{database},
);

my $db_version = '';
eval {
    open my $fh, '>', \my $stderr;
    local *STDERR = $fh;
    $db_version = $gd->database_version;
};

if (!$db_version) {
    $gd->deploy;
    say 'done migrate';
    exit;
}

if ($gd->check_version) {
    say 'Database is already latest';
}
else {
    print $gd->diff . "\n";
    if (!$options{'dry-run'}) {
        $gd->upgrade_database;
        say 'done migrate';
    }
}

if ($gd->check_version) {
    say 'Database is already latest';
}
else {
    print $gd->diff . "\n";
    if (!$options{"dry-run"}) {
        $gd->upgrade_database;
        say 'done migrate';
    }
}
