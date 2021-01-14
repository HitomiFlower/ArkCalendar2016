package Jobeet::Schema::ResultBase;
use v5.16.3;
use strict;
use warnings FATAL => 'all';
use parent 'DBIx::Class';
use utf8;

use JSON qw/to_json from_json/;

sub inflate_json_column {
    my $pkg = shift;
    my @columns = @_;

    for my $column (@columns) {
        $pkg->inflate_column(
            $column,
            {
                inflate => sub {
                    my $p = shift;
                    $p && from_json($p);
                },
                deflate => sub {
                    my $p = shift;
                    $p && to_json($p);
                },
            }
        );
    }
}

# Coreコンポーネントをロード
__PACKAGE__->load_components(qw/InflateColumn::DateTime Core/);

sub insert {
    my $self = shift;

    my $now = Jobeet::Schema->now;
    $self->created_at($now) if $self->can('created_at');
    $self->updated_at($now) if $self->can('updated_at');

    $self->next::method(@_);
}

sub update {
    my $self = shift;

    if ($self->can('updated_at')) {
        $self->updated_at(Jobeet::Schema->now);
    }

    $self->next::method(@_);
}

1;