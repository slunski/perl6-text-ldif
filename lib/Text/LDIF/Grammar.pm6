use v6;

grammar Text::LDIF::Grammar {
	token TOP { <version-spec> [ <ldif-changes> || <ldif-content> ] }

	token ldif-content { [<SEP>+ <ldif-attrval-record>]+ }
	token ldif-changes { [<SEP>+ <ldif-change-record>]+ }

	token ldif-attrval-record { <dn-spec> <SEP> <attrval-spec>+ }
	token ldif-change-record { <dn-spec> <SEP> <control>* <changerecord> }
	token version-spec { 'version:' <FILL> (<[0..9]>+) }

	token dn-spec { "dn:" [[<FILL> <distinguishedName>] | [':' <FILL> <base64-distinguishedName>]]  }

	token distinguishedName { <SAFE-STRING> }
	token base64-distinguishedName { <BASE64-UTF8-STRING> }

	token rdn { <SAFE-STRING> }

	token control { 'control:' <FILL> <ldap-oid> [ ' '+ $<value> = ['true' || 'false'] ]? <value-spec>? <SEP> }

	token ldap-oid { <[0..9]>+ ['.' <[0..9]>+]* }

	token attrval-spec { <AttributeDescription> <value-spec> <SEP> }

	token value-spec { ':' [ [ <FILL> <SAFE-STRING>? ]
	                       | [ ':' <FILL> <BASE64-STRING>? ]
		                   | [ '<' <FILL> <url> ] ] }

	token url { 'file://' (<-[\n]>+) } # FIXME a lazy hack

	token AttributeDescription { <!before dn:> <!before control:> <AttributeType> [';' <options>]? }

	token AttributeType { <ldap-oid> | [<[a..zA..Z]> <attr-type-chars>*] }

	token options { <option>+ % ';' }
	token option { <[0..9a..zA..Z-]>+ }

	token changerecord { 'changetype:' <FILL> [ <change-add> || <change-delete> || <change-modify> || <change-moddn> ] }
	token change-add { 'add' <SEP> <attrval-spec>+ }
	token change-delete { 'delete' <SEP> }
	token change-moddn {
		('modrdn' | 'moddn') <SEP>
		'newrdn:' [ <FILL> <rdn> | ':' <FILL> <base64-rdn> ] <SEP>
		'deleteoldrdn:' <FILL> $<del-on-rdn> = ['0' || '1'] <SEP>
		('newsuperior:' [ <FILL> <distinguishedName> || ':' <FILL> <base64-distinguishedName> ] <SEP> )?
	}

	token change-modify { 'modify' <SEP> <mod-spec>* }
	token mod-spec { $<op> = [ 'add' | 'delete' | 'replace' ] ':' <FILL> <AttributeDescription> <SEP> <attrval-spec>* '-' <SEP> }

	token attr-type-chars { <[a..zA..Z0..9-]> }

	token SAFE-STRING { (<SAFE-INIT-CHAR> <SAFE-CHAR>*)? }

	token SAFE-CHAR { <[ \x01..\x09 \x0B..\x0C \x0E..\x7F ]> }
	token SAFE-INIT-CHAR { <[ \x01..\x09 \x0B..\x0C \x0E..\x1F \x21..\x39 \x3B \x3D..\x7F ]> }

	token BASE64-UTF8-STRING { <BASE64-STRING> }
	token BASE64-STRING { <[\x2B \x2F \x30..\x39 \x3D \x41..\x5A \x61..\x7A]>* }

	token FILL { ' '* }
	token SEP { "\r\n" || "\n" }
}
