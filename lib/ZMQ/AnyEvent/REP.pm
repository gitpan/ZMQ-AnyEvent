package ZMQ::AnyEvent::REP;
{
  $ZMQ::AnyEvent::REP::VERSION = '0.001';
}
# ABSTRACT: Asynchronously serviced ZeroMQ REP Socket

use AnyEvent;
use Moose;
use ZeroMQ::Constants qw{:socket};
use namespace::autoclean;

extends 'ZMQ::AnyEvent';
with 'ZMQ::AnyEvent::Role::Receiver' => {reply => 1},
     'ZMQ::AnyEvent::Role::Sender';

sub _build_type {ZMQ_REP};


sub BUILD {
    my ($self) = @_;
    $self->socket->bind ($self->endpoint);
}


1;

__END__
=pod

=head1 NAME

ZMQ::AnyEvent::REP - Asynchronously serviced ZeroMQ REP Socket

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

=head2 send

The send method takes a list of items, packages them up as a
(potentially multi-part) message, and sends them off through the
socket.  It returns false in the event of an error.

=for Pod::Coverage BUILD

=head1 AUTHOR

Michael Alan Dorman <mdorman@ironicdesign.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Ironic Design, Inc..

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

