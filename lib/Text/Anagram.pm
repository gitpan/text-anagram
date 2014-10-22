package Text::Anagram;
use Exporter 'import';
use Modern::Perl;
our @EXPORT_OK = qw< anagram >;
our $VERSION   = '0.0';
# ABSTRACT: do something with every anagram of a text

=head1 DON'T

this release is usable but far from a definitive API. don't use in production

=head1 SYNOPSIS

    use Modern::Perl;
    use Text::Anagram qw< anagram >;

    anagram { say } "bob";

=head1 FUTURE

add a callback to stop a branch of solution

    use Modern::Perl;
    use Text::Anagram qw< anagram >;

    anagram "bob"
    , stop    => sub { length > 2 && /^ana/ }
    , finally => sub { say }

also 

    * localize stuff to run anagrams in anagrams
    * compare anything (not only char) ? 

=cut 

my $leaf_callback;

sub _anagram;
sub _anagram {
    my ( $from, $to) = @_;
    length $from or return map {$leaf_callback->()} $to;
    my %seen;
    $from =~ s{.}{ $seen{$&}++ or _anagram "$'$`","$&$to" }ge;
}

sub anagram (&$) {
    $leaf_callback = shift;
    my $seed = shift;
    _anagram $seed,'';
}

1;
