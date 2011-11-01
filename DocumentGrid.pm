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
	#Create a format suitable for the template
	my @eprints;
	# Iterate through the output list and pull out interesting data
	foreach my $eprint ($opts{list}->get_records()){
		my @documents;
		# Iterate though the documents in an eprint and add interesting data
		foreach my $doc ($eprint->get_all_documents()){
			push @documents, {
				img => $doc->thumbnail_url("preview"),
				url => $doc->get_url(),
				type => $doc->get_type(),
			};
		}
		push @eprints, {
			id => $eprint->get_id(),
			title => $eprint->get_value("title"),
			url => $eprint->get_url(),
			documents => \@documents,
		};
	}
	#Reference the template and render the array
	my $content = $xslate->render("DocumentGrid.kolon", {
		eprints => \@eprints,
	});
	
	#If there is a file handle print to it
	if (defined $opts{fh}){
		print {$opts{fh}} $content;
	}
	#otherwise return the content
	return $content;
}


1;
