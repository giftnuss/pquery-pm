use lib 'lib';
use Test::More tests => 2;
use pQuery;

my $html = do { local $/; <DATA> };

my $r = '';
pQuery($html)->find('a')->each(sub { $r.=$_->as_text });
is($r,'12','found the 2 links');

$r='';
pQuery($html)->find('a.foo')->each(sub { $r.=$_->as_text });
is($r,'1','found the first link by class name');

__DATA__
<html> <a class="foo">1</a> <a class="bar">2</a> </html>