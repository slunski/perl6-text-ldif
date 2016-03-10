v6;

grammar Text::LDIF::Grammar {
	token TOP { [ <comment>* <entry> \n? ]+ };
	token comment { ^^ '#' \N* \n };
	token entry { [ <dn> \n [ [ <comment>* <attr> ]+ % \n ] ] \n };
	token dn { <aname> [ ':' \s? ] <avalue> };
	token attr { ^^ <aname> [ ';' <option> ]* ':' [ ':' | '<' ]? \s? <avalue> };
	token option { [ \w | '-' ]+ };
	token aname { \w+ };
	token avalue { <value> [ [ \n ' ' ] <bvalue>+ ]* };
	token value { \N+ };
	token bvalue { \N+ };
}

