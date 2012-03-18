package ZMQ::AnyEvent::Role::Sender;
{
  $ZMQ::AnyEvent::Role::Sender::VERSION = '0.001';
}
# ABSTRACT: Mix-in for sockets that can send (ignore)

use AnyEvent;
use Moose::Role;
use ZeroMQ::Constants qw{:socket};
use namespace::autoclean;


sub send {
    my ($self, @parts) = @_;
    my $final = pop @parts;
    for my $part (@parts) {
        AE::log trace => "Sending part %s", $part;
        $self->socket->send ($part, ZMQ_SNDMORE);
    }
    AE::log trace => "Final part is %s", $final;
    $self->socket->send ($final) == 0
}

1;

__END__
=pod

=head1 NAME

ZMQ::AnyEvent::Role::Sender - Mix-in for sockets that can send (ignore)

=head1 VERSION

version 0.001

=for Pod::Coverage send

=head1 AUTHOR

Michael Alan Dorman <mdorman@ironicdesign.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Ironic Design, Inc..

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

