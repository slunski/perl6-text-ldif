v6;

grammar Text::LDIF::Grammar {
	token TOP { [ \n* <comment>* \n* <entry> \n? <comment>* \n? ]+ };
	token comment { ^^ '#' \N* \n };
	token entry { <dn> \n [ [ <comment>* <attr> ]+ % \n ] \n };
	token dn { 'dn:' \s? <dvalue> };
	token dvalue { <dv> [ \n ' ' <bvalue>+ ]* };
	token dv { \N+ };
	token attr { ^^ <aname> [ ';' <option> ]* ':' <binaryorurl>? \s? <avalue> };
	token option { [ \w | '-' ]+ };
	token binaryorurl { ':' | '<' };
	token aname { \w+ };
	token avalue { <value> [ \n ' ' <bvalue>+ ]* };
	token value { \N* };
	token bvalue { \N+ };
}

