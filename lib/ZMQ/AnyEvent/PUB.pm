package ZMQ::AnyEvent::PUB;
{
  $ZMQ::AnyEvent::PUB::VERSION = '0.001';
}
# ABSTRACT: Asynchronously serviced ZeroMQ PUB Socket

use AnyEvent;
use Moose;
use ZeroMQ::Constants qw{:socket};
use namespace::autoclean;

extends 'ZMQ::AnyEvent';
with 'ZMQ::AnyEvent::Role::Sender';

sub _build_type {ZMQ_PUB};


sub BUILD {
    my ($self) = @_;
    AE::log trace => "Binding socket to %s", $self->endpoint;
    $self->socket->bind ($self->endpoint);
}


1;

__END__
=pod

=head1 NAME

ZMQ::AnyEvent::PUB - Asynchronously serviced ZeroMQ PUB Socket

=head1 VERSION

version 0.001

=head1 ATTRIBUTES

=head2 endpoint

The endpoint attribute must be given a string representing the ZeroMQ
socket to work with.

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

