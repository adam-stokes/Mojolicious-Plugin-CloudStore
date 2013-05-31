package Mojolicious::Plugin::CloudStore::Provider::S3;

use strictures 1;
use Mojo::Base 'Mojolicious::Plugin::CloudStore::Provider';
use Data::Dump qw[pp];

has 'access_key_id';
has 'secret_access_key';
has 'bucket';

# VERSION

sub save {
    my $self = shift;
    my $img = shift;
    pp($self);
}

sub remove {
    my $self = shift;
}

sub image {
    my $self = shift;
}

sub image_url {
    my $self = shift;
}

sub public {
    my $self = shift;
}

sub private {
    my $self = shift;
}

1;
__END__

=head1 NAME

Mojolicious::Plugin::CloudStore::Provider::S3 - CloudStore Amazon S3 interface

=head1 DESCRIPTION

Amazon S3 Storage provider.

=cut
