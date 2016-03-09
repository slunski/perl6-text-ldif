v6;

use Text::LDIF::Grammar;
#use Text::LDIF::Actions;

sub parse( $txt ) {
	my $r = Text::LDIF::Grammar.parse( $txt );
	return $r;
}
sub subparse( $txt ) {
	my $r = Text::LDIF::Grammar.subparse( $txt );
	return $r;
}
#sub debug( $txt ) {
#	use Grammar::Debugger;
#	my $r = Text::LDIF::Grammar.parse( $txt );
#	return $r;
#}
sub parsefile( $file ) {
	#my $txt = slurp $file;
	my $r = Text::LDIF::Grammar.parsefile( $file );
	return $r;
}

class Text::LDIF {
multi method parse( $txt ) {
	my $r = Text::LDIF::Grammar.parse( $txt );
	return $r;
}
multi method parse( $txt, $actions ) {
	my $r = Text::LDIF::Grammar.parse( $txt, :actions( $actions ) );
	return $r;
}

multi method subparse( $txt ) {
	my $r = Text::LDIF::Grammar.subparse( $txt );
	return $r;
}
multi method subparse( $txt, $actions ) {
	my $r = Text::LDIF::Grammar.subparse( $txt, :actions( $actions ) );
	return $r;
}

}

