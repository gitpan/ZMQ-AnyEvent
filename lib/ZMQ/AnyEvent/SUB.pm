package ZMQ::AnyEvent::SUB;
{
  $ZMQ::AnyEvent::SUB::VERSION = '0.001';
}
# ABSTRACT: Asynchronously serviced ZeroMQ SUB Socket

use AnyEvent;
use Moose;
use ZeroMQ::Constants qw{:socket};
use namespace::autoclean;

extends 'ZMQ::AnyEvent';
with 'ZMQ::AnyEvent::Role::Receiver';

has topics => (default => sub {[]},
               handles => {list_topics => 'elements'},
               is => 'ro',
               isa => 'ArrayRef',
               required => 1,
               traits => ['Array']);

sub _build_type {ZMQ_SUB};


sub BUILD {
    my ($self) = @_;
    map {
        $self->subscribe ($_)
    } $self->list_topics;
    AE::log trace => "Connecting socket to %s", $self->endpoint;
    $self->socket->connect ($self->endpoint);
}


sub subscribe {
    my ($self, $topic) = @_;
    AE::log trace => "Subscribing socket to %s", $_;
    $self->socket->setsockopt (ZMQ_SUBSCRIBE, $topic);
}


sub unsubscribe {
    my ($self, $topic) = @_;
    AE::log trace => "Unsubscribing socket from %s", $_;
    $self->socket->setsockopt (ZMQ_UNSUBSCRIBE, $topic);
}

1;

__END__
=pod

=head1 NAME

ZMQ::AnyEvent::SUB - Asynchronously serviced ZeroMQ SUB Socket

=head1 VERSION

version 0.001

=head1 ATTRIBUTES

=head2 endpoint

The endpoint attribute must be given a string representing the ZeroMQ
socket to work with.

=head2 on_read

The on_read attribute must be given a coderef that will be called
whenever a new message is received.  If the callback returns a result,
that will be sent as a reply to the sender.

=head1 METHODS

=head2 subscribe

Subscribe the socket to the given topic.  These subscriptions use pure
prefix matching, so you have to keep it simple.

=head2 unsubscribe

Unsubscribe the socket to the given topic.

=for Pod::Coverage BUILD

=head1 AUTHOR

Michael Alan Dorman <mdorman@ironicdesign.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Ironic Design, Inc..

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

