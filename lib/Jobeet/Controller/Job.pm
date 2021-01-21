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

    $c->stash->{job} = models('Schema::Job')->find({ token => $job_token })
        or $c->detach('/default');

    # $key名で保存されたデータを取得
    my $history = $c->session->get('job_history') || [];

    unshift @$history, { $c->stash->{job}->get_columns };
    # $key名で$valueというデータを保存
    $c->session->set(job_history => $history);
}

# /job/create (new)
sub create :Local :Form('Jobeet::Form::Job') {
    my ($self, $c) = @_;

    if ($c->req->method eq 'POST' and $self->form->submitted_and_valid) {
        my $job = models('Schema::Job')->create_from_form($self->form);
        $c->redirect($c->uri_for('/job', $job->token));
    }
}

sub job :Chained('/') :PathPart :CaptureArgs(1) {
    my ($self, $c, $job_token) = @_;

    $c->stash->{job} = models('Schema::Job')->find({ token => $job_token })
        or $c->detach('/default');
}

# /job/{job_token}/edit
sub edit :Chained('job') :PathPart :Form('Jobeet::Form::Job') {
    my ($self, $c) = @_;

    my $job = $c->stash->{job};

    if ($c->req->method eq 'POST') {
        if ($self->form->submitted_and_valid) {
            $job->update_from_form($self->form);
            $c->redirect($c->uri_for('/job', $job->token));
        }
    }
    else {
        $self->form->fill({
            $job->get_columns,
            category => $job->category->slug,
        });
    }
}

# /job/{job_token}/delete
sub delete :Chained('job') :PathPart :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{job}->delete;
    $c->redirect($c->uri_for('/job'));
}

sub publish :Chained('job') :PathPart {
    my ($self, $c) = @_;

    my $job = $c->stash->{job};

    $job->publish;
    $c->redirect($c->uri_for('/job', $job->token));
}

__PACKAGE__->meta->make_immutable;