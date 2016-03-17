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
		my %o = $e<option> if $e<option>;
		for @a -> $attr {
			for @$attr -> $p {
				say "\tname -> ", $p.key, "\n\tvalue -> ", $p.value;
			}
		}
		if %o {
			for %o.kv -> $k,$v {
				say "\toption -> ", $k, " -> ", $v;
			}
		}
		say "-" x 50;
	}
} else {
	say "Parsing error";
}

