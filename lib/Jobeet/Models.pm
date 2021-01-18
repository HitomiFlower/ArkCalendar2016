package Jobeet::Models;
use strict;
use v5.16.3;
use warnings;
use Ark::Models '-base'; # アプリケーションのモデルクラスという設定

# モデルを登録する
register Schema => sub {
    # 初期化処理、最後にこのモデルのオブジェクトを返す
    my $self = shift;

    # $self->get('conf')はconfig.plを読み取る設定
    my $conf = $self->get('conf')->{database}
        or die 'require database config';

    $self->ensure_class_loaded('Jobeet::Schema');
    Jobeet::Schema->connect(@$conf);
};

autoloader qr/^Schema::/ => sub {
    my ($self, $name) = @_;

    my $schema = $self->get('Schema');
    for my $t ($schema->sources) {
        $self->register("Schema::$t" => sub {$schema->resultset($t)});
    }
};

for my $table (qw/Job Category CategoryAffiliate Affiliate/) {
    register "Schema::$table" => sub {
        my $self = shift;
        $self->get('Schema')->resultset($table);
    }
}

1;
