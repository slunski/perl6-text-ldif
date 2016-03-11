v6;

use Test;

use Text::LDIF;

my $file = "examples/1.ldif";

plan(2);

my $l = Text::LDIF.new();
ok $l, 'class OK';

my $r = $l.parsefile( $file );

ok $r, 'parsefile OK';

