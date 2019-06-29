use v6;

use Test;
use Text::LDIF;

my $ldif = Text::LDIF.new;
my IO $prefix = '.'.IO.child('t/testdata/');

sub check-parses(Str $fn, &check) {
    my $ldif-text = slurp $prefix.child("$fn.ldif");
    subtest { &check($ldif.parse($ldif-text)) }, "subtests for case $fn";
}

check-parses '1', -> $r {
    is $r<version>, 1, "Version is correct";
    my $recs = $r<records>;
    is $recs.elems, 2, "Two entries were read";

    is $recs[0]<dn>, 'cn=Barbara Jensen, ou=Product Development, dc=airius, dc=com', "DN is correct for first entry";
    my $rec-attrs = $recs[0]<attrs>;
    is $rec-attrs<objectclass>, <top person organizationalPerson>, "objectclass multi-values are concatenated";
    is $rec-attrs<sn>, 'Jensen', "sn is correct";
    is $rec-attrs<telephonenumber>, '+1 408 555 1212', 'phonenumber is read ok';

    is $recs[1]<dn>, 'cn=Bjorn Jensen, ou=Accounting, dc=airius, dc=com', 'DN is correct for second entry';
    $rec-attrs = $recs[1]<attrs>;
    is $rec-attrs<objectclass>, <top person organizationalPerson>, 'objectclass multi-values are concatenated';
}

check-parses '2', -> $r {
    is $r<records>[0]<attrs><description>, 'Babs is a big sailing fan, and travels extensively in search of perfect sailing conditions.',
            'folded description was concatenated';
}

check-parses '3', -> $r {
     is $r<records>[0]<attrs><description>, Pair.new('base64', 'V2hhdCBhIGNhcmVmdWwgcmVhZGVyIHlvdSBhcmUhICBUaGlzIHZhbHVlIGlzIGJhc2UtNjQtZW5jb2RlZCBiZWNhdXNlIGl0IGhhcyBhIGNvbnRyb2wgY2hhcmFjdGVyIGluIGl0IChhIENSKS4NICBCeSB0aGUgd2F5LCB5b3Ugc2hvdWxkIHJlYWxseSBnZXQgb3V0IG1vcmUu'),
            'base64 value is read';
}

check-parses '4', -> $r {
    my $ou = $r<records>[0]<attrs><ou>;
    is-deeply $ou{''}, Pair.new('base64', '5Za25qWt6YOo'), "Option-less attribute";
    is-deeply $ou<lang-en>, 'Sales', "Simple option attribute";
    is-deeply $ou<lang-ja>, Pair.new('base64', '5Za25qWt6YOo'), 'BASE64 option attribute';
    is-deeply $ou<lang-ja,phonetic>, Pair.new('base64', '44GI44GE44GO44KH44GG44G2'), 'Multi-option attribute';
}

check-parses '5', -> $r {
    is-deeply $r<records>[0]<attrs><jpegphoto>, Pair.new('file', 'file://foo.jpg'), 'External file url';
}

check-parses '6', -> $r {
    my $changes = $r<changes>;

    my $change = $changes[0];
    is-deeply $change<dn>, 'cn=Fiona Jensen, ou=Marketing, dc=airius, dc=com';
    is $change<change>.key, 'add';
    is $change<change>.value<cn>, 'Fiona Jensen';
    is-deeply $change<change>.value<jpegphoto>, Pair.new('file', 'file://foo.jpg');
    is-deeply $change<controls>, [];

    $change = $changes[1];
    is $change<change>, 'delete';

    $change = $changes[2];
    is $change<change>.key, 'moddn';
    ok $change<change><moddn><delete-on-rdn>;
    is $change<change><moddn><newrdn>, 'cn=Paula Jensen';

    $change = $changes[3];
    is $change<change>.key, 'moddn';
    nok $change<change><moddn><delete-on-rdn>;
    is $change<change><moddn><newrdn>, 'ou=Product Development Accountants';

    $change = $changes[4];
    is $change<change>.key, 'modify';
    is $change<change><modify>[0], Pair.new('add', Pair.new('postaladdress', '123 Anystreet $ Sunnyvale, CA $ 94086'));
    is $change<change><modify>[1], Pair.new('delete', 'description');
    is $change<change><modify>[2], Pair.new('replace', Pair.new('telephonenumber', ('+1 408 555 1234', '+1 408 555 5678')));

    $change = $changes[5];
    is $change<change>.key, 'modify';
    is $change<change><modify>[0], Pair.new('replace', 'postaladdress');
    is $change<change><modify>[1], Pair.new('delete', 'description');
}

check-parses '7', -> $r {
    is $r<changes>[0]<dn>, 'ou=Product Development, dc=airius, dc=com';
    is $r<changes>[0]<controls>[0]<ldap-oid>, '1.2.840.113556.1.4.805';
    ok $r<changes>[0]<controls>[0]<criticality>;
}

done-testing;