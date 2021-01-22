package Jobeet::Controller::Search;
use strict;
use warnings FATAL => 'all';
use Ark 'Controller';

use Jobeet::Models;

sub index :Path {
    my ($self, $c) = @_;

    my $query = $c->req->param('q')
        or $c->detach('/default');

    $c->stash->{jobs} = models('Schema::Job')->search_fulltext($query);

    my $request = $c->req->header('X-Requested-With');
    if (defined($request) && $request =~ /XMLHttpRequest/i) {
        $c->view('MT')->template('search/ajax');
    }
}

1;