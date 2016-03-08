v6;

use Text::LDIF;

my $txt = slurp @*ARGS[0];

my $l = Text::LDIF.new();

#say Text::LDIF::Grammar.parse( $txt );
say $l.parse( $txt );

