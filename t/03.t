v6;

use Test;

use Text::LDIF;

# big .ldif file
my $txt = slurp "examples/2.ldif";

plan(2);

my $l = Text::LDIF.new();
ok $l, 'class OK';

#say Text::LDIF::Grammar.parse( $txt );
my $r = $l.parse( $txt );

ok $r, 'parse OK';

