v6;

use Test;

use Text::LDIF;

#my $txt = slurp "../examples/simple.ldif";
my $file = "examples/1.ldif";

plan(2);

my $l = Text::LDIF.new();
ok $l, 'class OK';

#say Text::LDIF::Grammar.parse( $txt );
my $r = $l.parsefile( $file );

ok $r, 'parsefile OK';

