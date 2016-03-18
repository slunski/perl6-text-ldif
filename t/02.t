v6;

use Test;

use Text::LDIF;
use Text::LDIF::Actions;

my $txt = slurp "examples/1.ldif";

plan(5);

my $l = Text::LDIF.new();
ok $l, 'class OK';

my $a = Text::LDIF::Actions.new();
ok $a, 'actions OK';

my $r = $l.parse( $txt, $a );
ok $r, 'parse OK';

my $dn = 1;
for @$r -> $e {
	$dn = 0 if ! $e<dn>;
}
ok $dn, 'dn OK';

my $at = 1;
for @$r -> $e {
	# < 2 becouse at least "objectClass" and attribute are needed
	$at = 0 if $e<attrs>.elems < 2;
}
ok $at, 'attr OK';

