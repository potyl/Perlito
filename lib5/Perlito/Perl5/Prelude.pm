# Do not edit this file - Generated by Perlito 7.0
use v5;
use utf8;
use strict;
use warnings;
no warnings ('redefine', 'once', 'void', 'uninitialized', 'misc', 'recursion');
use Perlito::Perl5::Runtime;
use Perlito::Perl5::Prelude;
our $MATCH = Perlito::Match->new();
{
package GLOBAL;
    sub new { shift; bless { @_ }, "GLOBAL" }

    # use v6 
;
    {
    package Perlito::Match;
        sub new { shift; bless { @_ }, "Perlito::Match" }
        sub from { $_[0]->{from} };
        sub to { $_[0]->{to} };
        sub str { $_[0]->{str} };
        sub bool { $_[0]->{bool} };
        sub scalar {
            my $self = $_[0];
            substr($self->{str}, $self->{from}, (($self->{to} - $self->{from})))
        }
    }

;
    {
    package Pair;
        sub new { shift; bless { @_ }, "Pair" }
        sub key { $_[0]->{key} };
        sub value { $_[0]->{value} };
        sub perl {
            my $self = $_[0];
            return scalar (($self->{key} . ' ' . chr(61) . chr(62) . ' ' . Main::perl($self->{value}, )))
        }
    }


}

1;
