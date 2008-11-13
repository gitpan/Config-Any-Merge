use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
	module_name         => 'Config::Any::Merge',
	license             => 'perl',
	dist_author         => 'Mario Domgoergen <dom@math.uni-bonn.de>',
	dist_version_from   => 'lib/Config/Any/Merge.pm',
	build_requires => {
		'Test::More' => 0,
	},
	requires => {
		'Config::Any' => 0,
	},
	add_to_cleanup      => [ 'Config-Any-Merge-*' ],
	create_makefile_pl  => 'traditional',
);

$builder->create_build_script();
