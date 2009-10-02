package WWW::Shorten::Durl;

use strict;
use warnings;
use Carp;
use URI::Escape;

use base qw(WWW::Shorten::generic Exporter );
our @EXPORT = qw( makeashorterlink makealongerlink get_capture_image );
our $VERSION = '0.01';

sub makeashorterlink ($) {
  my $url = uri_escape(shift) or croak 'No URL passed to makeashorterlink';
  my $ua = __PACKAGE__->ua();
  my $durl = "http://durl.me/api/Create.do?longurl=$url";
  my $res = $ua->get($durl);
  return undef unless $res->is_success;
  my ($short_url) = $res->content =~ m!\[(http://durl.me/\w+)\]!;
  return $short_url;  
}

sub makealongerlink ($) {
  my $url = uri_escape(shift) or croak 'No URL passed to makealongerlink';
  my ($key) = $url =~ m!http%3A%2F%2Fdurl.me%2F(\w+)!;
  my $durl = "http://durl.me/$key.status";
  my $ua = __PACKAGE__->ua();
  my $res = $ua->get($durl);
  return undef unless $res->is_success;
  my ($long_url) = $res->content =~ m/<url><\!\[CDATA\[([^<]+)\]\]><\/url>/;
  return $long_url;
}

sub get_capture_image ($) {

}
1;
__END__

=head1 NAME

WWW::Shorten::Durl - Perl interface to durl.me

=head1 SYNOPSIS

  use WWW::Shorten::Durl;
  use WWW::Shorten:: 'Durl';
  
  # .......
  # .......
  
  $short_url = makeashorterlink($long_url);
  
  $long_url = makealongerlink($short_url);

=head1 DESCRIPTION

WWW::Shorten::Durl is a Perl interface to the web site durl.me, Durl maintains a database of long URLs, each of which has a unique identifier.

=head1 AUTHOR

JEEN E<lt>jeen@perl.krE<gt>

=head1 SEE ALSO

L<WWW::Shorten>, L<http://durl.kr/doc/OpenAPI.html>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
