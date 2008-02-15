use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Acme::Rautavistic::Sort',
    license             => 'perl',
    dist_author         => 'Steffen Schwigon <ss5@renormalist.net>',
    dist_version_from   => 'lib/Acme/Rautavistic/Sort.pm',
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'Acme-Rautavistic-Sort-*' ],
);

$builder->create_build_script();
