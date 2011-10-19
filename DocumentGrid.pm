package EPrints::Plugin::Export::DocumentGrid;

use Unicode::String qw( utf8 );

use EPrints::Plugin::Export;
use Text::Xslate;

use File::Basename;

@ISA = qw( EPrints::Plugin::Export);

use strict;
my $dirname = dirname(__FILE__);
my $xslate = Text::Xslate->new(
    path      => ["$dirname"],
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
	my @eprints;
	foreach my $eprint ($opts{list}->get_records()){
		my @documents;
		foreach my $doc ($eprint->get_all_documents()){
			push @documents, {
				img => $doc->thumbnail_url("preview"),
			};
		}
		push @eprints, {
			id => $eprint->get_id(),
			title => $eprint->get_value("title"),
			documents => \@documents,
		};
	}

	my $content = $xslate->render("DocumentGrid.kolon", {
		eprints => \@eprints,
	});
	
	if (defined $opts{fh}){
		print {$opts{fh}} $content;
	}
	return $content;
}


1;
