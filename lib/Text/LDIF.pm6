v6;

use Text::LDIF::Grammar;
#use Text::LDIF::Actions;

# LDAP::* moved to separate repo...
class LDAP::Attribute {
	has Str $.name;
	has Str @.values;
	has Str @.options;
}
class LDAP::Entry {
	has Str $.dn;
	has LDAP::Attribute @.objectclass;
	has LDAP::Attribute @.attributes;
}


class Text::LDIF {

#grammar LDIF {
#	#token TOP { <entry>+ % [ ^^ \n ] };
#	token TOP { [ <comment>* <entry> \n? ]+ };
#	token comment { ^^ '#' \N+ \n };
#	token entry { [ [ <comment>* <attr> ]+ % \n ] \n };
#	#token atrs { [ <aname> ':' [ \s? <avalue> | ':' \s? <bvalue> ] \n? ]+ };
#	token attr { ^^ <aname> [ ';' <option> ]* ':' <value> };
#	token aname { \w+ };
#	token option { [ \w | '-' ]+ };
#	token value { \s? <avalue> | ':' \s? <bvalue> | '<' \s? <uvalue> };
#	token avalue { \N+ };
#	token bvalue { \N+ [ \n ' ' \N+ ]+ };
#	token uvalue { \N+ };
#}

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

multi method parse( $txt ) {
	my $r = Text::LDIF::Grammar.parse( $txt );
	return $r;
}
multi method parse( $txt, $actions ) {
	my $r = Text::LDIF::Grammar.parse( $txt, :actions( $actions ) );
	return $r;
}

}

