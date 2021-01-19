package Jobeet::Schema::Result::Job;
use v5.16.3;
use strict;
use warnings FATAL => 'all';
use parent 'Jobeet::Schema::ResultBase';
use Jobeet::Schema::Types;
use Jobeet::Models;
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
    company      => VARCHAR(
        is_nullable => 1,
    ),
    logo         => VARCHAR(
        is_nullable => 1,
    ),
    url          => VARCHAR(
        is_nullable => 1,
    ),
    expires_at   => DATETIME,
    created_at   => DATETIME,
    updated_at   => DATETIME,
);

# Primary key
__PACKAGE__->set_primary_key('id');
# INDEX
__PACKAGE__->add_unique_constraint([ 'token' ]);
# リレーション関係指定
# JobとCategoryは1対多関係
__PACKAGE__->belongs_to(category => 'Jobeet::Schema::Result::Category', 'category_id');

# insertの場合処理
sub insert {
    my $self = shift;

    # 新規登録時にexpires_atが30日後に自動的にセットされる
    $self->expires_at(models('Schema')->now->add(days => models('conf')->{active_days}));
    $self->next::method(@_); # 他の場所でinsertをフックしている場合にそちらのメソッドにも処理を投げる
}

1;