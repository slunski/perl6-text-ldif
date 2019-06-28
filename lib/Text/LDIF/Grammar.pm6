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

	regex url { 'file://' (<-[\n]>+) } # FIXME a lazy hack

	regex AttributeDescription { <!before dn:> <!before control:> <AttributeType> [';' <options>]? }

	regex AttributeType { <ldap-oid> | [<[a..zA..Z]> <attr-type-chars>*] }

	regex options { <option>+ % ';' }
	regex option { <[0..9 a..z A..Z -]>+ }

	regex changerecord { 'changetype:' <FILL> [ <change-add> || <change-delete> || <change-modify> || <change-moddn> ] }
	regex change-add { 'add' <SEP> <attrval-spec>+ }
	regex change-delete { 'delete' <SEP> }
	regex change-moddn {
		('modrdn' | 'moddn') <SEP>
		'newrdn:' [ <FILL> <rdn> | ':' <FILL> <base64-rdn> ] <SEP>
		'deleteoldrdn:' <FILL> $<del-on-rdn> = ['0' || '1'] <SEP>
		('newsuperior:' [ <FILL> <distinguishedName> || ':' <FILL> <base64-distinguishedName> ] <SEP> )?
	}

	regex change-modify { 'modify' <SEP> <mod-spec>* }
	regex mod-spec { $<op> = [ 'add' | 'delete' | 'replace' ] ':' <FILL> <AttributeDescription> <SEP> <attrval-spec>* '-' <SEP> }

	regex attr-type-chars { <[a..zA..Z0..9-]> }

	regex SAFE-STRING { (<SAFE-INIT-CHAR> <SAFE-CHAR>*)? }

	regex SAFE-CHAR { <[ \x01..\x09 \x0B..\x0C \x0E..\x7F ]> }
	regex SAFE-INIT-CHAR { <[ \x01..\x09 \x0B..\x0C \x0E..\x1F \x21..\x39 \x3B \x3D..\x7F ]> }

	regex BASE64-UTF8-STRING { <BASE64-STRING> }
	regex BASE64-STRING { <[\x2B \x2F \x30..\x39 \x3D \x41..\x5A \x61..\x7A]>* }

	regex FILL { ' '* }
	regex SEP { "\r\n" || "\n" }
}
