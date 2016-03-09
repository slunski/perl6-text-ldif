v6;

use Text::LDIF;
use Text::LDIF::Actions;

my $txt = slurp @*ARGS[0];

my $l = Text::LDIF.new();

my $a = Text::LDIF::Actions.new();

#$l.parse( $txt, Text::LDIF::Actions );
say  $l.parse( $txt, $a ).ast;


