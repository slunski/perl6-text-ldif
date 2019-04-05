v6;

use Test;

use Text::LDIF;
use Text::LDIF::Actions;

my $file = "examples/1.ldif";
#my $t = slurp $file;
plan(3);

my $l = Text::LDIF.new();
ok $l, 'class OK';

my $r = $l.parsefile( $file );
#my $r = $l.parse( $t );
ok $r, 'parsefile OK';

my $a = Text::LDIF::Actions.new;

$r = $l.parsefile( $file, $a );
ok $r, 'parsefile with actions OK';

