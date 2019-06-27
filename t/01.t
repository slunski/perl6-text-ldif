use v6;

use Test;

use Text::LDIF;

my $txt = slurp "examples/simple.ldif";

my $l = Text::LDIF.new();
ok $l, 'class OK';

my $r = $l.parse( $txt );

ok $r, 'parse OK';

done-testing;