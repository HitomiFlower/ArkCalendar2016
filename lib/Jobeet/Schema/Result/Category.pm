package Jobeet::Schema::Result::Category;
use v5.16.3;
use strict;
use warnings FATAL => 'all';
use parent 'Jobeet::Schema::ResultBase';
use Jobeet::Models;
use Jobeet::Schema::Types;
use utf8;

__PACKAGE__->table('jobeet_category');

__PACKAGE__->add_columns(
    id   => PK_INTEGER,
    name => VARCHAR,
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint([ 'name' ]);

__PACKAGE__->has_many(jobs => 'Jobeet::Schema::Result::Job', 'category_id');
__PACKAGE__->has_many(
    category_affiliate => 'Jobeet::Schema::Result::CategoryAffiliate', 'category_id');
__PACKAGE__->many_to_many(affiliates => category_affiliate => 'affiliate');

sub get_active_jobs {
    my $self = shift;
    my $attr = shift || {};

    $attr->{rows} ||= 10;

    $self->jobs(
        { expires_at => { '>=', models('Schema')->now->strftime("%F %T") } },
        { order_by => { -desc => 'created_at' },
            rows   => $attr->{rows},
        }
    );
}

1;