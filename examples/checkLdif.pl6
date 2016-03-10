v6;

use Text::LDIF;
use Text::LDIF::Grammar;
use Text::LDIF::Actions;

my $t = slurp @*ARGS[0];

my $l = Text::LDIF.new();
my $a = Text::LDIF::Actions.new();

#my $r = Text::LDIF::Grammar.parse( $t );
my $r = $l.parse( $t, $a ).ast;

if $r {
	#say $r;
	for @$r -> $e {
		say "dn -> ", $e<dn>;

		my @a = $e<attrs>;
		for @a -> $attr {
			#for %$attr.kv -> $k,$v {
			#	say "\tname -> ", $k, "\n\tvalue -> ", $v;
			#}
			for @$attr -> $p {
				
				say "\tname -> ", $p.key, "\n\tvalue -> ", $p.value;
			}
		}
		say "-" x 50;
	}
}

