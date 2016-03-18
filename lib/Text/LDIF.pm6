v6;

use Text::LDIF::Grammar;

class Text::LDIF {

multi method parse( $txt ) {
	my $r = Text::LDIF::Grammar.parse( $txt );
	return $r;
}
multi method parse( $txt, $actions ) {
	my $r = Text::LDIF::Grammar.parse( $txt, :actions( $actions ) );
	return $r.ast;
}
multi method subparse( $txt ) {
	my $r = Text::LDIF::Grammar.subparse( $txt );
	return $r.ast;
}
multi method subparse( $txt, $actions ) {
	my $r = Text::LDIF::Grammar.subparse( $txt, :actions( $actions ) );
	return $r.ast;
}
multi method parsefile( $file ) {
	my $r = Text::LDIF::Grammar.parsefile( $file );
	#return $r.ast;
	return $r;
}
multi method parsefile( $file, $actions ) {
	my $r = Text::LDIF::Grammar.parsefile( $file, :actions( $actions ) );
	#return $r.ast;
	return $r;
}
#method debug( $txt ) {
#	use Grammar::Debugger;
#	my $r = Text::LDIF::Grammar.parse( $txt );
#	return $r.ast;
#}
}

