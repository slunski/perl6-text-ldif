v6;

class Text::LDIF::Actions {
	method TOP($/) {
		make $<entry>>>.ast;
	};
	method entry($/) {
		my %a; my %o;
		my @l = $<attr>>>.ast;
		for @l -> $b {
			my ($k, $v, $o) = @$b;
			%a{$k}.push: $v;
			%o{$k} = $o if $o;
		}
		my %e = dn => ~$<dn><dvalue>;
		%e<attrs> = %a;
		%e<option> = %o if %o;;
		make %e;
	}
	method attr($/) {
		my @o = $<option>>>.ast if $<option>;
		push @o, ~$<binaryorurl>.ast if $<binaryorurl>;
		my $v = ~$<avalue><value>;
		$v = $v ~ $<avalue><bvalue>>>.ast.join("") if $<avalue><bvalue>;
		my @result = (~$<aname>, $v);
		push @result, @o if @o;
		make @result;
	}
	method aname($/) {
		make ~$/;
	}
	method option($/) {
		make ~$/;
	}
	method binaryorurl($/) {
		my $bu;
		my $m = ~$/;
		if $m eq ':' {
			$bu = 'binary';
		} else {
			$bu = 'url';
		}
		make ~$bu if $bu;
	}
	#method avalue($/) {
	#	my $b = ~$<bvalue>>>.ast;
	#	my $c = $<value> ~ $b;
	#	say "c:", $c, ":";
	#	make ~$c;
	#}
	method bvalue($/) {
		make ~$/;
	}
}

