package EPrints::Plugin::Export::DocumentGrid;

use Unicode::String qw( utf8 );

use EPrints::Plugin::Export;
use Template::Mustache;

@ISA = qw( EPrints::Plugin::Export Template::Mustache );

use strict;

sub new
{
	my( $class, %opts ) = @_;

	my $self = $class->SUPER::new( %opts );

	$self->{name} = "Document Grid";
	$self->{accept} = [ 'list/eprint' ];

	$self->{visible} = "all";

	$self->{suffix} = ".html";
	$self->{mimetype} = "text/html";

	$self->{table_width} = 5;

	return $self;
}




sub output_list
{
	my( $plugin, %opts ) = @_;
	my $session = $plugin->{session};

	my @document_cells;

	$opts{list}->map( sub {
		my( $session, $dataset, $item ) = @_;
		my $eprint_title = $item->get_value('title'); #or use item->get_citation_link if you want to be more linky and less pithy
		foreach my $doc ($item->get_all_documents())
		{
			push @document_cells, $plugin->create_document_td($doc,$eprint_title);
		}
	} );


	my $table = $session->make_element('table');
	my $tr = $session->make_element($tr);
	$table->appendChild($tr);

	my $i = 0;
	foreach (@document_cells)
	{
		$tr->appendChild($_);
		$i++;
		if ($i >= $plugin->{table_width})
		{
			$i = 0;
			$tr = $session->make_element('tr');
			$table->appendChild($tr);
		}
	}
	
	

	# my $page = '<html><head><title>Document Grid</title><style></style></head><body>' . $table->toString . '</body></html>'; #you should probably do this properly
#also, the correct way to toString a dom element is EPrints::Utils::tree_to_utf8($dom), but it didn't work here.  No idea why.

	my $page = '<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /><style> a {text-decoration: none; color: black}</style><title>EPrints Document Grid</title></head><body>' . $table->toString . '</body></html>' . $plugin->render();

	if( defined $opts{fh} )
	{
		print {$opts{fh}} $page;
	}

	return $page;
}


sub create_document_td
{
	my ($plugin, $doc, $eprint_title) = @_;

# print STDERR ref $doc;

	my $session = $plugin->{session};

	my $td = $session->make_element('td');
	my $para = $session->make_element('p');

	#I suggest you test what thumbnail_url returns and put in a default image if it returns nothing.
	$td->appendChild($session->make_element('img', src => $doc->thumbnail_url('preview')));  #there are other sizes you can ask for.

	my $a = $session->make_element('a', href=> $doc->get_url());

	$a->appendChild($session->make_text($eprint_title));
	$para->appendChild($a);
	$td->appendChild($para);

	return $td;
}








1;
