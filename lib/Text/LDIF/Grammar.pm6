v6;

grammar Text::LDIF::Grammar {
	token TOP { [ <comment>* <entry> \n? ]+ };
	token comment { ^^ '#' \N+ \n };
	token entry { [ <dn> \n [ [ <comment>* <attr> ]+ % \n ] ] \n };
	token attr { ^^ <aname> [ ';' <option> ]* ':' <value> };
	token dn { <aname> [ ':' \s? ] <avalue> };
	token aname { \w+ };
	token option { [ \w | '-' ]+ };
	token value { \s? <avalue> | ':' \s? <bvalue> | '<' \s? <uvalue> };
	token avalue { \N+ };
	token bvalue { \N+ [ \n ' ' \N+ ]+ };
	token uvalue { \N+ };
}

