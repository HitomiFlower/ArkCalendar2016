package Jobeet::Controller;
use Ark 'Controller';
use Jobeet::Models;

# default 404 handler
sub default :Path :Args {
    my ($self, $c) = @_;

    $c->res->status(404);
    $c->res->body('404 Not Found');
}

sub index :Path :Args(0) {
    my ($self, $c) = @_;
    $c->res->body('Ark Default Index');
}

# end アクションはコントローラの実行の最後に実行される特別なアクション
sub end :Private {
    my ($self, $c) = @_;

    unless ($c->res->body or $c->res->status =~ /^3\d\d/) {
        $c->forward($c->view('MT'));
    }
}

__PACKAGE__->meta->make_immutable;