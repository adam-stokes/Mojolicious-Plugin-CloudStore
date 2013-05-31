package Mojolicious::Plugin::CloudStore;

use strictures 1;
use Mojo::Base 'Mojolicious::Plugin';
use Class::Load 'load_class';

# VERSION

sub register {
    my ($self, $app, $conf) = @_;

    $conf ||= {};
    $self->check_options(%$conf);
    $conf->{'provider'} ||= 'S3';

    $app->helper(
        cloudstore => sub {

            # TODO: Expand once other providers are added
            my $class = "Mojolicious::Plugin::CloudStore::Provider::S3";
            load_class($class);
            $class->new(
                access_key_id     => $conf->{apikey},
                secret_access_key => $conf->{apisecret},
                bucket            => $conf->{specifics}->{bucket},
            );

        }
    );

}

sub check_options {
    my $self = shift;
    my %options = @_;

    if (!exists $options{apikey} || !exists $options{apisecret}) {
        die "Api key and secret required.";
    }
    if (exists $options{provider} && $options{provider} !~ /^(S3)$/i) {
        die "CloudStore only supports Amazon S3 currently.";
    }

    return $self;
}

###############################################################################
# Exposed API
###############################################################################
sub save      { }
sub remove    { }
sub image     { }
sub image_url { }
sub public    { }
sub private   { }

1;
__END__

=head1 NAME

Mojolicious::Plugin::CloudStore - Mojolicious Plugin

=head1 SYNOPSIS

  # Mojolicious

  # Amazon S3 Storage
  $self->plugin(
    'CloudStore' => {
        provider    => 'S3',
        apikey      => 'api key',
        apisecret   => 'api secret',
        specifics   => {
           bucket => 'my-s3-bucket',
        },
    },
  );

  # Mojolicious::Lite
  plugin 'CloudStore';


=head1 DESCRIPTION

L<Mojolicious::Plugin::CloudStore> is a L<Mojolicious> plugin.

=head1 NOTICE

Amazon S3 is the only provider supported at this time, more to come soon.

=head1 METHODS

L<Mojolicious::Plugin::CloudStore> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 register

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=head2 save

  $self->cloudstore->save($image);

Saves image object to cloud.

=head2 remove

  $self->cloudstore->remove($image);

Removes image from cloud.

=head2 image

  $self->cloudstore->image($image);

Returns image object.

=head2 image_url

  $self->cloudstore->image_url($image);

Returns public accessibl image url in the cloud.

=head2 public

  $self->cloudstore->public($image);

Enables image to be accessible publicly.

=head2 private

  $self->cloudstore->private($image);

Disable public attribute for image.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=cut
