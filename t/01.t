v6;

use Test;

use Text::LDIF;

my $txt = slurp "examples/simple.ldif";

plan(2);

my $l = Text::LDIF.new();
ok $l, 'class OK';

my $r = $l.parse( $txt );

ok $r, 'parse OK';

