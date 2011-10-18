package EPrints::Plugin::Export::DocumentGrid;

use Unicode::String qw( utf8 );

use EPrints::Plugin::Export;
use IO::String;
use Text::Xslate;

@ISA = qw( EPrints::Plugin::Export);

use strict;

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
		
		my $outstring = "";
		my $io = IO::String->new($outstring);
        
        print $io "<html><head><head><body><ul>";
        
        foreach my $dataobj ($opts{list}->get_records){
				print $io "<li id='" . $dataobj->get_id() . ">" . $dataobj->get_value('title') . "<img src='" . $dataobj->get_thumbnail('preview') . "' /></li>";
		}
		
		print $io "</ul></body></html>";
		
		if (defined $opts{fh}){
			print {$opts{fh}} $outstring;
		}
		return $outstring;
}


1;
