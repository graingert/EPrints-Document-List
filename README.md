EPrints Document List
=====================
Because this code uses the Model View Template software architecture to 
isolate visual design from view logic. This code is made from multiple
files:

1. Perl module, DocumentGrid.pm
2. an XSlate2 template file DocumentGrid.kolon

NOTE: Multiple files mean that they are contained in an application/zip

The Perl module "View" iterates through an eprint list "Model" pulling
interesting information about the eprint and then about the documents in
each eprint. This data is formatted into an array and sent to the Xslate
template renderer.

[Fork Me On Github](https://github.com/graingert/Eprints-DocGrid "Eprints-DocGrid git repository")

Dependancies
------------
This code depends on Text::Xslate from CPAN

Intersting Output
-----------------
Links to example exports:

1. [A small example showing a few eprints](http://kanga-tag1g09.ecs.soton.ac.uk/cgi/exportview/creators/Al-Huseiny=3AMuayed=3A=3A/DocumentGrid/Al-Huseiny=3AMuayed=3A=3A.html)
2. [A large example showing every eprint from 2008](http://kanga-tag1g09.ecs.soton.ac.uk/cgi/exportview/year/2008/DocumentGrid/2008.html)

Screenshots
-----------
Some screenshots showing the output:

1. <img src="http://dl.dropbox.com/u/1353167/Eprints/a_few_documents.png"/>
2. <img src="http://dl.dropbox.com/u/1353167/Eprints/sometimes_eprints_have_no_previews.png"/>

