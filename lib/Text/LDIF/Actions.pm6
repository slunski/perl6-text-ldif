v6;

class Text::LDIF::Actions {
	method TOP($/) {
		make $<entry>>>.ast;
	};
	method entry($/) {
		make {
			dn => ~$<dn><avalue>,
			attrs => $<attr>>>.ast
		}
	}
	method attr($/) {
		my $v = ~$<avalue><value>;
		my $b = $<avalue><bvalue>>>.ast.join("") if $<avalue><bvalue>;
		$v = $v ~ $b if $b;
		#say "v:", $v;
		make ~$<aname> => $v;
	}
	method aname($/) {
		make ~$/;
	}
	#method avalue($/) {
	#	my $b = ~$<bvalue>>>.ast;
	#	my $c = $<value> ~ $b;
	#	say "c:", $c, ":";
	#	make ~$c;
	#}
	method bvalue($/) {
		my $b = ~$/;
		make $b;
	}
}

