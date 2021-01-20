package Jobeet::Controller::Job;
use Ark 'Controller';
with 'Ark::ActionClass::Form';

use Jobeet::Models;
has '+namespace' => default => 'job'; # URL対応

# /boo/bar
# sub bar :Path('bar') メソッド名は関係ない
# /boo/の場合Pathに何も指定しない
# Argsにパラメータ受け取る数を指定. 0の場合が省略できる
sub index :Path {
    my ($self, $c) = @_;

    $c->stash->{categories} = models('Schema::Category')->get_with_jobs;
}

# job/{job_token}(detail)
sub show :Path :Args(1) {
    my ($self, $c, $job_token) = @_;
}

# /job/create (new)
sub create :Local :Form('Jobeet::Form::Job') {
    my ($self, $c) = @_;

    $c->stash->{form} = $self->form;
}


sub job :Chained('/) :PathPart :CapureArgs(1) {
    my ($self, $c, $job_token) = @_;
    $c->stash->{job_token} = $job_token;
}

# /job/{job_token}/edit
sub edit :Chained('job) :PathPart :Args(0) {
    my ($self, $c) = @_;
}

# /job/{job_token}/delete
sub delete :Chained('job) :PathPart :Args(0) {
    my ($self, $c) = @_;
}

__PACKAGE__->meta->make_immutable;