package ZMQ::AE;
{
  $ZMQ::AE::VERSION = '0.001';
}
# ABSTRACT: Easy construction of asynchronously serviced ZeroMQ sockets


sub REQ ($&) {
    my ($endpoint, $cb) = @_;
    require ZMQ::AnyEvent::REQ;
    ZMQ::AnyEvent::REQ->new (endpoint => $endpoint, on_read => $cb);
}


sub REP ($&) {
    my ($endpoint, $cb) = @_;
    require ZMQ::AnyEvent::REP;
    ZMQ::AnyEvent::REP->new (endpoint => $endpoint, on_read => $cb);
}


sub DEALER ($&) {
    my ($endpoint, $cb) = @_;
    require ZMQ::AnyEvent::DEALER;
    ZMQ::AnyEvent::DEALER->new (endpoint => $endpoint, on_read => $cb);
}


sub ROUTER ($&) {
    my ($endpoint, $cb) = @_;
    require ZMQ::AnyEvent::ROUTER;
    ZMQ::AnyEvent::ROUTER->new (endpoint => $endpoint, on_read => $cb);
}


sub PUB ($) {
    my ($endpoint) = @_;
    require ZMQ::AnyEvent::PUB;
    ZMQ::AnyEvent::PUB->new (endpoint => $endpoint);
}


sub SUB ($$&) {
    my ($endpoint, $topics, $cb) = @_;
    require ZMQ::AnyEvent::SUB;
    ZMQ::AnyEvent::SUB->new (endpoint => $endpoint, on_read => $cb, topics => $topics);
}


sub PUSH ($) {
    my ($endpoint) = @_;
    require ZMQ::AnyEvent::PUSH;
    ZMQ::AnyEvent::PUSH->new (endpoint => $endpoint);
}


sub PULL ($&) {
    my ($endpoint, $cb) = @_;
    require ZMQ::AnyEvent::PULL;
    ZMQ::AnyEvent::PULL->new (endpoint => $endpoint, on_read => $cb);
}

1;

__END__
=pod

=head1 NAME

ZMQ::AE - Easy construction of asynchronously serviced ZeroMQ sockets

=head1 VERSION

version 0.001

=head1 SYNOPSIS

use ZMQ::AE;

=head1 DESCRIPTION

This is a module establishing a bunch of factory functions for
ZMQ::AnyEvent sockets. 

=head1 METHODS

=head2 ZMQ::AE::REQ ($endpoint, \&callback->(@message_parts));

A shorthand method for constructing a ZMQ::AnyEvent::REQ socket
connected to the specified endpoint.

Each time a message is received, the callback routine will be called
with all of the parts of the (possibly multi-part) message.

=head2 ZMQ::AE::REP ($endpoint, \&callback->(@message_parts));

A shorthand method for constructing a ZMQ::AnyEvent::REP socket bound
to the specified endpoint.

Each time a message is received, the callback routine will be called
with all of the parts of the (possibly multi-part) message.

=head2 ZMQ::AE::DEALER ($endpoint, \&callback->(@message_parts));

A shorthand method for constructing a ZMQ::AnyEvent::DEALER socket
connected to the specified endpoint.

Each time a message is received, the specified callback will be called
with all of the parts of the (possibly multi-part) message.

=head2 ZMQ::AE::ROUTER ($endpoint, \&callback->(@message_parts));

A shorthand method for constructing a ZMQ::AnyEvent::Router socket
bound to the specified endpoint.

Each time a message is received, the callback routine will be called
with all of the parts of the (possibly multi-part) message.

=head2 ZMQ::AE::PUB ($endpoint);

A shorthand method for constructing a ZMQ::AnyEvent::Pub socket
bound to the specified endpoint.

=head2 ZMQ::AE::SUB ($endpoint, \@topics, \&callback->(@message_parts));

A shorthand method for constructing a ZMQ::AnyEvent::Sub socket
connected to the specified endpoint, and subscribed to the listed
topics.

Each time a message is received, the callback routine will be called
with all of the parts of the (possibly multi-part) message.

=head2 ZMQ::AE::PUSH ($endpoint);

A shorthand method for constructing a ZMQ::AnyEvent::PUSH socket
connected to the specified endpoint.

=head2 ZMQ::AE::PULL ($endpoint, \&callback->(@message_parts));

A shorthand method for constructing a ZMQ::AnyEvent::PULL socket bound
to the specified endpoint.

Each time a message is received, the callback routine will be called
with all of the parts of the (possibly multi-part) message.

=head1 AUTHOR

Michael Alan Dorman <mdorman@ironicdesign.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Ironic Design, Inc..

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

