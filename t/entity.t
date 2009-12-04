use Test::More tests => 2;
# file starts from rt-cpan #40795 by http://oid.fox.geek.nz/kent.fredric 

use pQuery;

open FILE, 't/document1.html' or die $!;
my $html = do {local $/; <FILE>};
close FILE;
chomp $html;

my $output = '';

my $pq = pQuery($html);

$pq->find('li')->each(sub {
 $_->text("<bad");
});

$output = $pq->toHtml();
like $output, qr/&lt;bad/, "Output Contains Escaped Entity";
unlike $output , qr/<bad/ , "Output Does Not Contain Bare Entity" ;
