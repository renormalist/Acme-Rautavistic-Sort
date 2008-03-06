use strict;
use warnings;

package Acme::Rautavistic::Sort::XS;

our $VERSION = '0.01';
our @ISA;

eval {
	require XSLoader;
	XSLoader::load( __PACKAGE__, $VERSION );
	1;
} or do {
	require DynaLoader;
	push @ISA, 'DynaLoader';
	__PACKAGE__->bootstrap($VERSION);
};

1;

__END__

xsubpp .xs->.c
Build .c -> .so
XSLoader/DynaLoader   machen dl_open, aus .so Symbole in akt. Programm, dann mit long jump zu
                      XS_Foo__Bar_boot (auch von xsubpp automatisch generiert)
                      die registriert xsubs mit Perl
                      hängt C-Funktion in Perl rein

DynaLoader ist älter, erfordert aber, dass man von ihm erbt, daher lieber cooleres XSLoader

 
