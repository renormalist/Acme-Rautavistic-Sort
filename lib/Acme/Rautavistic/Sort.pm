package Acme::Rautavistic::Sort;

#use warnings;
use strict;

require Exporter;

use vars qw(@ISA @EXPORT_OK %EXPORT_TAGS);

@ISA = qw(Exporter);

@EXPORT_OK   = qw(dropsort dropsort1 dropsort2 dropsort3 dropsort4 dropsort5);
%EXPORT_TAGS = (all => [qw(dropsort dropsort1 dropsort2 dropsort3 dropsort4 dropsort5)]);

#use Data::Dumper; print STDERR Dumper(\@res);

*{dropsort} = *{dropsort5};

sub dropsort1 {
#    no warnings;
    return unless @_;
    my @res = ($_[0]);
    #@res = scalar @_; # Cheat: allozieren
    $_[$_] ge $res[-1] && push @res, $_[$_] for 1 .. $#_;
    @res;
}

sub dropsort2 {
#    no warnings;
    my @res = @_;
    #@res = scalar @_; # Cheat: allozieren

    for ($_ = 1; $_ < @res; $_++) {
        $res[$_] lt $res[$_-1] && splice(@res, $_--, 1);
    }
    @res;
}

sub dropsort3 {
    my $last;
    grep
    {
        (not defined $last)
         ||
        (defined $_ && $_ ge $last)
         and
        ($last = $_ or 1)
    } @_;
}

sub dropsort4 {
    my $last;
    map
    {
     (not defined $last) || (defined $_ && $_ ge $last)
       ? $last = $_
       : ()
    } @_;
}

sub dropsort5 {
#    no warnings;
    my $last;
    map { $_ ge $last ? $last = $_ : () } @_;
}

# sub dropsort {
#     return unless @_;

#     my @res = map {
#                    $_ == 0 ? $_[$_]
#                            : $_[$_] ge $res[-1] ? $_[$_]
#                                                 : ()
#                   } 0..$#_; # (@_-1);
#     use Data::Dumper; print STDERR Dumper(\@res);
#     return @res;
# }

=head1 NAME

Acme::Rautavistic::Sort - Silly rautavistic sort algorithms

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

...

=head1 DESCRIPTION

Taken from http://www.dangermouse.net/esoteric/dropsort.html:

Dropsort is a fast, one-pass sorting algorithm suitable for many
applications.

Algorithm Description Dropsort is run on an ordered list of numbers by
examining the numbers in sequence, beginning with the second number in
the list. If the number being examined is less than the number before
it, drop it from the list. Otherwise, it is in sorted order, so keep
it. Then move to the next number.

After a single pass of this algorithm, the list will only contain
numbers that are at least as large as the previous number in the
list. In other words, the list will be sorted!  Analysis Dropsort
requires exactly n-1 comparisons to sort a list of length n, making
this an O(n) algorithm, superior to the typical O(n logn) algorithms
commonly used in most applications.

Dropsort is what is known in the computer science field as a lossy
algorithm. It produces a fast result that is correct, but at the cost
of potentially losing some of the input data. Although to those not
versed in the arts of computer science this may seem undesirable,
lossy algorithms are actually a well-accepted part of computing. An
example is the popular JPEG image compression format, which enjoys
widespread use because of its versatility and usefulness. In similar
fashion, dropsort promises to revolutionise the sorting of data in
fields as diverse as commercial finance, government record-keeping,
and space exploration.

=head1 EXPORT

...

=head1 FUNCTIONS

=head2 dropsort

=head2 bogosort

=head1 AUTHOR

Steffen Schwigon, C<< <ss5 at renormalist.net> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-acme-rautavistic-sort at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Acme-Rautavistic-Sort>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Acme::Rautavistic::Sort

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Acme-Rautavistic-Sort>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Acme-Rautavistic-Sort>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Acme-Rautavistic-Sort>

=item * Search CPAN

L<http://search.cpan.org/dist/Acme-Rautavistic-Sort>

=back

=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2008 Steffen Schwigon, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Acme::Rautavistic::Sort
