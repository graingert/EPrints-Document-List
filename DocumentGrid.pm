package EPrints::Plugin::Export::DocumentGrid;

use Unicode::String qw( utf8 );

use EPrints::Plugin::Export;
use Text::Xslate;

use FindBin qw($Bin);

@ISA = qw( EPrints::Plugin::Export);

use strict;

my $xslate = Text::Xslate->new(
    path      => ["$Bin"],
);

sub new
{
	my( $class, %opts ) = @_;

	my $self = $class->SUPER::new( %opts );

	$self->{name} = "Document Grid";
	$self->{accept} = [ 'list/eprint' ];

	$self->{visible} = "all";

	$self->{suffix} = ".html";
	$self->{mimetype} = "text/html; charset=utf-8";

	return $self;
}

sub output_list
{
	my ($plugin, %opts) = @_;
	my @eprints = $opts{list}->get_records;

	my $content = $xslate->render("DocumentGrid.kolon", {
		eprints => @eprints,
	});
	
	if (defined $opts{fh}){
		print {$opts{fh}} $content;
	}
	return $content;
}


1;
