package Jobeet::Schema::Result::Job;
use v5.16.3;
use strict;
use warnings FATAL => 'all';
use parent 'Jobeet::Schema::ResultBase';
use Jobeet::Schema::Types;
use utf8;

# ここにテーブル定義
__PACKAGE__->table('jobeet_job');
__PACKAGE__->add_columns(
    id           => PK_INTEGER,
    category_id  => INTEGER,
    type         => VARCHAR(
        is_nullable => 1,
    ),
    position     => VARCHAR,
    location     => VARCHAR(
        is_nullable => 1,
    ),
    description  => TEXT,
    how_to_apply => TEXT,
    token        => VARCHAR,
    is_public    => TINYINT,
    is_activated => TINYINT,
    email        => VARCHAR,
    expires_at   => DATETIME,
    created_at   => DATETIME,
    updated_at   => DATETIME
);

# Primary key
__PACKAGE__->set_primary_key('id');
# INDEX
__PACKAGE__->add_unique_constraint(['token']);
# リレーション関係指定
# JobとCategoryは1対多関係
__PACKAGE__->belongs_to( category => 'Jobeet::Schema::Result::Category', 'category_id' );


1;