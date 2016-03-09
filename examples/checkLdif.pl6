v6;

use Text::LDIF;
use Text::LDIF::Grammar;

my $t = slurp @*ARGS[0];

my $l = Text::LDIF.new();

#my $r = $l.subparse( $t );
my $r = Text::LDIF::Grammar.subparse( $t );

say $r.perl;


