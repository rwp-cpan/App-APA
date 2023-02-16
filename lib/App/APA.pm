use v5.37.9;
use experimental qw( class try builtin );
use builtin qw( true false trim );

package App::APA;

class App::APA;

use HTTP::Tiny; # methods: get
use URI;
use XML::RSS; # methods: parse

field $uri = URI -> new( 'https://apa.az/en/rss' );

my $http = HTTP::Tiny -> new;
my $rss = XML::RSS -> new;

# TODO: Make this a private method once supported
method get_items ( ) {
  my $content = $http -> get( $uri ) -> {content}; # Hashref
  $rss -> parse( $content );
  my @items = $rss -> {items} -> @*; # Arrayref of hashrefs (keys: title, pubDate)
  return @items;
}

method uri ( ) {
  return $uri;
}

=attr uri

Return the URL of the news website

=cut

method first_item ( ) {
  my @items = $self -> get_items;
  return trim $items[0] -> {title};
}

=method first_item()

Returns the first item of the recent news list

=cut

method limit_items ( $number ) {
  my @items = $self -> get_items;
  my @number;
  for ( 0 .. $number - 1 ) {
    push @number , trim $items[$_] -> {title};
  }
  return @number;
}

=method limit_items($number)

Returns the number of items specified from the recent news list

=cut

method all_items ( ) {
  my @items = $self -> get_items;
  my @all;
  for my $item ( @items ) {
    push @all , trim $item -> {title};
  }
  return @all;
}

=method all_items($object)

Returns all items in the news list

The default limit for this is 300

=cut


=pod

$item hashref has C<pubDate>, C<category>, and C<link> keys in addition to C<title>

=cut
