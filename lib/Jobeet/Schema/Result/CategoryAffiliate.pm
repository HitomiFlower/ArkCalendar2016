package Jobeet::Schema::Result::CategoryAffiliate;
use v5.16.3;
use strict;
use warnings FATAL => 'all';
use parent 'Jobeet::Schema::ResultBase';
use utf8;

__PACKAGE__->table('jobeet_category_affiliate');

__PACKAGE__->add_columns(
    category_id  => {
        data_type         => 'INTEGER',
        is_nullable       => 0,
        is_auto_increment => 1,
        extra             => {
            unsigned => 1,
        },
    },
    affiliate_id => {
        data_type   => 'INTEGER',
        is_nullable => 0,
        extra       => {
            unsigned => 1,
        },
    }
);

__PACKAGE__->set_primary_key(qw/category_id affiliate_id/);

__PACKAGE__->belongs_to(
    category => 'Jobeet::Schema::Result::Category', 'category_id' );
__PACKAGE__->belongs_to(
    affiliate => 'Jobeet::Schema::Result::Affiliate', 'affiliate_id' );

1;