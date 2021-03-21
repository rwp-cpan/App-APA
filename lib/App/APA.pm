package App::APA;
use v5.32;
use experimental qw(signatures);
use HTTP::Tiny; # methods: get
use URI;
use XML::RSS; # methods: parse

my $http = HTTP::Tiny -> new();
my $uri = URI -> new('https://apa.az/en/rss');
my $rss = XML::RSS -> new();

my $content = $http -> get($uri) -> {content}; # \%
$rss -> parse($content);
my @items = $rss -> {items} -> @*; # \@ of \% (keys: title, pubDate)

sub new($class) {
  return bless({ url => $uri }, $class);
}

sub first($object) {
  return $items[0] -> {title} =~ s(^\s+|\s+$)()gr;
}

sub number($object, $number) {
  my @number;
  for (0 .. $number - 1)
  {
    push( @number, $items[$_] -> {title} =~ s(^\s+|\s+$)()gr );
  }
  return @number;
}
    
sub all($object) {
  my @all;
  for my $item (@items) {
    push( @all, $item -> {title} =~ s(^\s+|\s+$)()gr );
  }
  return @all;
}

1;

=pod

$item hashref has C<pubDate>, C<category>, and C<link> keys in addition to C<title>

=cut
