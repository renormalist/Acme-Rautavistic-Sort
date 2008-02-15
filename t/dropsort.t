#!perl -T

use strict;
use warnings;

use Test::More 'no_plan';
use Acme::Rautavistic::Sort ':all';

# plan tests => 11;

is_deeply([ dropsort(qw(3 2 3 1 5)) ], [ qw( 3 3 5) ], );
is_deeply([ dropsort(qw(3 1 2 )) ], [ qw( 3 ) ], "stark kleiner dann schwach groesser");
is_deeply([ dropsort(qw(0 0 )) ], [ qw( 0 0 ) ], "0 muss true sein");
is_deeply([ dropsort(qw(undef undef )) ], [ qw( undef undef ) ], "0 muss true sein");
is_deeply([ dropsort(qw(undef 1 undef )) ], [ qw( undef undef ) ], "undef gt 1");
is_deeply([ dropsort(qw(undef 0 undef )) ], [ qw( undef undef ) ], "undef gt 0");
is_deeply([ dropsort(qw(undef 1 undef )) ], [ qw( undef undef ) ], "undef gt 1");
is_deeply([ dropsort(qw(undef zaffe undef )) ], [ qw( undef zaffe ) ]);

is_deeply([ dropsort(undef, undef) ], [ undef, undef ]);
is_deeply([ dropsort(undef, 1, undef ) ], [ undef, 1 ] );
is_deeply([ dropsort(undef, 0, undef ) ], [ undef, 0 ] );
is_deeply([ dropsort(undef, 1, undef, 2 ) ], [ undef, 1, 2 ], );
is_deeply([ dropsort(undef, 1, undef, 0 ) ], [ undef, 1 ], );
is_deeply([ dropsort(undef, 1, 2 ) ], [ undef, 1, 2 ], );
is_deeply([ dropsort(undef, 2, 1 ) ], [ undef, 2 ], );
is_deeply([ dropsort(undef, 'zaffe', undef ) ], [ undef, 'zaffe' ]);

is_deeply([ dropsort(qw(3 2 4 1 5)) ], [ qw( 3 4 5) ], );
is_deeply([ dropsort(qw(3 4 5 6 7 8)) ], [ qw(3 4 5 6 7 8) ], );
is_deeply([ dropsort(qw(9 8 7 6 5 4)) ], [ qw(9 ) ], );
is_deeply([ dropsort(qw(2)) ], [ qw(2) ], );
is_deeply([ dropsort() ], [ ], );

is_deeply([ dropsort(qw(cc bb dd aa ee))], [qw(cc dd ee) ] );
is_deeply([ dropsort(qw(aa bb cc dd ee ff)) ], [ qw(aa bb cc dd ee ff) ] );
is_deeply([ dropsort(qw(ii hh gg ff ee dd)) ], [ qw(ii) ] );
is_deeply([ dropsort(qw(bb)) ], [ qw(bb) ] );

is_deeply([dropsort (1, 2, 5, 3, 4, undef)], [ 1, 2, 5 ]);
is_deeply([dropsort (1, 2, undef, 5, 3, 4, undef)], [ 1, 2, 5 ]);
is_deeply([undef], [ undef ]);

# -------------- Benchmarks -----------------------

use Benchmark qw(:all) ;

my @bigarray = map { rand } 1..100000;

print "Anzahl: ", (scalar dropsort5 @bigarray), "\n";

timethese(100, {
                'dropsort1' => sub { dropsort1 @bigarray },
                'dropsort2' => sub { dropsort2 @bigarray },
                'dropsort3' => sub { dropsort3 @bigarray },
                'dropsort4' => sub { dropsort4 @bigarray },
                'dropsort5' => sub { dropsort5 @bigarray },
               });
