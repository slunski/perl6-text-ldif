use v6;

class Text::LDIF::Actions {
	method TOP($/) {
		my %attrs = version => $<version-spec>[0].Int;

		with $<ldif-changes> {
			%attrs<changes> = .made;
		} orwith $<ldif-content> {
			%attrs<entries> = .made;
		}
		make %attrs;
	};

	method ldif-content($/) {
		make $<ldif-attrval-record>>>.made;
	}

	method ldif-attrval-record($/) {
		my $attrs = $<attrval-spec>>>.made.classify(*.key, as => *.value);
		$attrs = self!unwrap-opts($attrs);
		make %(dn => $<dn-spec>.made, :$attrs);
	}
	method !unwrap-opts($attributes) {
		my %attrs;
		for $attributes.kv -> $k, $v {
			if $v.elems == 1 {
				%attrs{$k} = $v[0];
			} else {
				%attrs{$k} = $v.List;
			}
		}
		if %attrs.elems == 1 {
			# We have only single key, so return a single Pair
			return %attrs.keys[0] => %attrs{%attrs.keys[0]};
		}
		%attrs;
	}

	method dn-spec($/) {
		with $<distinguishedName> {
			make .Str;
		} orwith $<base64-distinguishedName> {
			make Pair.new('base64', .Str);
		}
	}

	method attrval-spec($/) {
		with $<AttributeDescription> -> $attr {
			my $attribute = $attr<AttributeType>.Str;
			# If attribute has options, add those too
			$attribute ~= ';' ~ $_.Str with $attr<options>;
			my $value = $<value-spec>.made;
			make Pair.new($attribute, $value);
		}
	}

	method value-spec($/) {
		with $<SAFE-STRING> {
			make .Str;
		} orwith $<BASE64-STRING> {
			make Pair.new('base64', .Str);
		} orwith $<url> {
			make Pair.new('file', .Str);
		}
	}

	method ldif-changes($/) {
		make $<ldif-change-record>>>.made;
	}

	method ldif-change-record($/) {
		my @controls = $<control>>>.made;
		my $change = $<changerecord>.made;
		make %(dn => $<dn-spec>.made, :@controls, :$change);
	}

	method control($/) {
		my %attrs = ldap-oid => ~$<ldap-oid>,
				criticality => $<value> eq 'true',
				value => $<value-spec>.made;
		make %attrs;
	}

	method changerecord($/) {
		make ($<change-add> // $<change-delete> // $<change-modify> // $<change-moddn>).made;
	}

	method change-add($/) {
		my $attrs = $<attrval-spec>>>.made.classify(*.key, as => *.value);
		$attrs = self!unwrap-opts($attrs);
		make Pair.new('add', $attrs);
	}

	method change-delete($/) {
		make 'delete';
	}

	method change-modify($/) {
		make Pair.new('modify', $<mod-spec>>>.made);
	}

	method mod-spec($/) {
		my $attribute;
		with $<AttributeDescription> -> $attr {
            $attribute = $attr<AttributeType>.Str;
			# if attribute has options, add them too
            $attribute ~= ';' ~ $_.Str with $attr<options>;
		}
		my $vals = $<attrval-spec>>>.made.classify(*.key, as => *.value);
		if $vals {
			$vals = self!unwrap-opts($vals);
			make Pair.new(~$<op>, $vals);
		} else {
			make Pair.new(~$<op>, $attribute);
		}
	}

	method change-moddn($/) {
		my $newrdn;
		with $<rdn> {
			$newrdn = ~$_;
		} orwith $<base64-rdn> {
			$newrdn = base64 => ~$_;
		}
		my $delete-on-rdn = $<del-on-rdn> eq '1';
		my $newsuperior;
		with $<distinguishedName> {
			$newsuperior = ~$_;
		} orwith $<base64-distinguishedName> {
			$newsuperior = base64 => ~$_;
		}
		make Pair.new('moddn', %(:$newrdn, :$delete-on-rdn, :$newsuperior));
	}
}

