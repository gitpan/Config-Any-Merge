package Config::Any::Merge;

use warnings;
use strict;
use base 'Config::Any';

our $VERSION = '0.03';

sub _load {
	my($class,$args) = @_;
	my %config_merged;

	$args->{flatten_to_hash} = 1;

	my $override = 1;
	if (defined $args->{override} ) {
		$override = $args->{override};
		delete $args->{override};
	}
	
	my @files;

	if ($override) {
		@files = @{$args->{files}};
	} else {
		@files = reverse @{$args->{files}};
	}

	$args->{files} = \@files;

	my $config_any = $class->SUPER::_load($args);

	foreach my $file (@files) {
		while (my ($key,$val) = each %{$config_any->{$file}}) {
			$config_merged{$key} = $val;
		}
	}
	return \%config_merged;
}

1; # End of Config::Any::Merge
__END__

=head1 NAME

Config::Any::Merge - Overrinding of configuration variables based on file order

=head1 VERSION

Version 0.03

=cut

=head1 DESCRIPTION

Config::Any returns your configuration as a hash of hashes keyed by the
name of the configuration file. This module merges these hashes into a
single hash. If the C<override> paramter is set to C<0> in the paramters
for C<load_files> or C<load_stems>, configurations files later in the
list can't override variables that are already set. The default is to
override previous set variables. In all other regards Config::Any::Merge
is a strict subclass of Config::Any and inherits all of its functions.

=head1 SYNOPSIS

    use Config::Any::Merge;

    my $cfg = Config::Any->load_files({files => \@filepaths, override => 0, ...  });

=head1 DEPENDENCIES

C<Config::Any> >= 0.15

=head1 SEE ALSO

C<Config::Any>

=head1 AUTHOR

Mario Domgoergen, C<< <dom at math.uni-bonn.de> >>

=head1 LICENSE AND COPYRIGTH

Copyright 2008 Mario Domgoergen, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
