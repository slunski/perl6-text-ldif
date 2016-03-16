v6;

use Text::LDIF;
#use Text::LDIF::Actions;

my $l = Text::LDIF.new();
#my $a = Text::LDIF::Actions.new();

for @*ARGS -> $file {
	my $t = slurp $file;

	#my $r = $l.parse( $t, $a );
	my $r = $l.parse( $t );

	if ! $r {
		say "BAD: $file";
	}
}

