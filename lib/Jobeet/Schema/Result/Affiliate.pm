package Jobeet::Schema::Result::Affiliate;
use v5.16.3;
use strict;
use warnings FATAL => 'all';
use parent 'Jobeet::Schema::ResultBase';
use Jobeet::Schema::Types;
use utf8;

__PACKAGE__->table('jobeet_affiliate');

__PACKAGE__->add_columns(
    id         => PK_INTEGER,
    url        => VARCHAR,
    email      => VARCHAR,
    token      => VARCHAR(
        size => 80,
    ),
    is_active  => TINYINT,
    created_at => DATETIME,
);

# Primary key
__PACKAGE__->set_primary_key('id');
# INDEX
__PACKAGE__->add_unique_constraint([ 'email' ]);
__PACKAGE__->has_many(
    category_affiliate => 'Jobeet::Schema::Result::CategoryAffiliate', 'affiliate_id',
    {
        is_foreign_key_constraint => 0,
        cascade_delete            => 0,
    },
);
__PACKAGE__->many_to_many(categories => category_affiliate => 'category');

1;