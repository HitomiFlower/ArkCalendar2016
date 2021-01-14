package Jobeet::Schema::Types;
use v5.16.3;
use strict;
use warnings FATAL => 'all';
use parent 'Exporter';
our @EXPORT = qw/PK_INTEGER INTEGER VARCHAR TEXT TINYINT DATETIME/;

sub PK_INTEGER {
    +{
        data_type         => 'INTEGER',
        is_nullable       => 0,
        is_auto_increment => 1,
        extra             => {
            unsigned => 1,
        },
        @_,
    };
}

sub INTEGER {
    +{
        data_type   => 'INTEGER',
        is_nullable => 0,
        extra       => {
            unsigned => 1,
        },
        @_,
    };
}

sub TINYINT {
    +{
        data_type     => 'TINYINT',
        is_nullable   => 0,
        default_value => 0,
        extra         => {
            unsigned => 1,
        },
        @_,
    };
}

sub VARCHAR {
    +{
        data_type   => 'VARCHAR',
        size        => 255,
        is_nullable => 0,
        @_,
    };
}

sub TEXT {
    +{
        data_type   => 'TEXT',
        is_nullable => 0,
        @_,
    };
}

sub DATETIME {
    +{
        data_type   => 'DATETIME',
        is_nullable => 0,
        timezone    => Jobeet::Schema->TZ,
        @_,
    };
}

1;