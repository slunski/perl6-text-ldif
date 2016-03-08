v6;

use Text::LDIF;
use Text::LDIF::Actions;

my $txt = slurp @*ARGS[0];

my $l = Text::LDIF.new();

my LDAP::Entry @es;

my $a = Text::LDIF::Actions.new();

#$l.parse( $txt, Text::LDIF::Actions );
$l.parse( $txt, $a );

