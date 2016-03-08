v6;

class Text::LDIF::Actions {
	method TOP($/) {
		make $<entry>>>.ast;
	};
	method entry($/) {
		make { 
			dn => ~$<dn><avalue>,
			attr => $<attr>.map(*.ast).list
		}
	}
	method attr($/) {
		make ~$<aname> => $<value><avalue> ?? ~$<value><avalue> !!
							$<value><bvalue> ?? ~$<value><bvalue> !! ~$<value><uvalue>
	}
	method aname($/) {
		make ~$/;
	}
	method value($/) {
		make ~$/;
	}
	method avalue($/) {
		make ~$/;
	}
	method bvalue($/) {
		make ~$/;
	}
	method uvalue($/) {
		make ~$/;
	}
}

