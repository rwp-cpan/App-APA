use v5.32;
use lib qw(/home/regular/var/git/App-APA/lib);
use Getopt::Std; # function: getopts
use Pod::Usage; # function: pod2usage
use App::APA;

getopts('fn:a', \ our %options);
binmode(STDOUT, ':encoding(UTF-8)'); # warning: wide character

my $apa = App::APA -> new();

fif ( defined($options{f}) ) {
  say $apa -> first();
}
elsif ( defined($options{n}) ) {
  say for $apa -> number($options{n});
}
elsif ( defined($options{a}) ) {
  say for $apa -> all();  
}
else {
  say pod2usage(verbose => 1);
}

=pod

=head1 NAME
apa.pl - App::APA frontend to parse RSS news

=head1 SYNOPSIS
apa -f
apa -n <number>
apa -a

=head1 DESCRIPTION

=head2 OPTIONS

=over

=item -f
first news item

=item -n
fetch specified number of news items

=item -a
all news items

=back

=head1 SEE ALSO

L<XML::RSS>

=cut
