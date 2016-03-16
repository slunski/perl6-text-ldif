v6;

use Text::LDIF;
use Text::LDIF::Actions;

my $t = slurp @*ARGS[0];

my $l = Text::LDIF.new();
my $a = Text::LDIF::Actions.new();

my $r = $l.subparse( $t, $a ).ast;

if $r {
	#say $r.perl;
	for @$r -> $e {
		say "dn -> ", $e<dn>;
		my @a = $e<attrs>;
		#say "ca: ", @a.perl;
		for @a -> $attr {
			for @$attr -> $p {
				
				say "\tname -> ", $p.key, "\n\tvalue -> ", $p.value;
			}
		}
		say "-" x 50;
	}
} else {
	say "Parsing error";
}

