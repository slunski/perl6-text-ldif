### Text::LDIF

Text::LDIF is Perl6 module for parsing LDIF files.

### API

All parse methods return list entries as hashes. Hashes look like:

```perl6
%h = {
	dn => "ou=Organization Unit,o=Organization",	# entry DN
	attrs => {										# attributes
		attr1 => ["attr1 value1", "attr1 value2"],
		attr2 => ...
	},
	option => {										# options from some attrs
		attrx => [ "attrx option1", "attrx option2" ],
		attry => ...
	}
}
```

Available methods are:

```perl6
method parse( $txt [, Text::LDIF::Actions $actions] );
method subparse( $txt [, Text::LDIF::Actions $actions] );
method parsefile( $fileName [, Text::LDIF::Actions $actions] );
```

Example of use:

```perl6
use Text::LDIF;
use Text::LDIF::Actions;

my $t = slurp @*ARGS[0];

my $l = Text::LDIF.new();
my $a = Text::LDIF::Actions.new();

my $r = $l.parse( $t, $a );

if $r {
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
		say "-" x 40;
	}
	} else {
		say "Parsing error";
}
```

BUGS:

Grammar for basic attributes values use just \N* pattern so some
invalid values (eg. binary numbers with invalid format) are accepted.
If database don't allow such values they will be rejected during
import.
