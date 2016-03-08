v6;

class Text::LDIF::Actions {
	#method entry( $/ ) {
	#	say "--";
	#	say $/;
	#	say "--";
	#	$/.make( $/ );
	#}
	method aname( $/ ) {
		if $/ eq 'dn' {

		} else {
			print "$/: ";
		}
	}
	method avalue( $/ ) {
		say "$/";
	}
}

