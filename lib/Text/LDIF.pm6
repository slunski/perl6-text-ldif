use v6;

use Text::LDIF::Grammar;

class Text::LDIF {
    multi method parse($txt) {
        Text::LDIF::Grammar.parse($txt);
    }
    multi method parse($txt, $actions) {
        Text::LDIF::Grammar.parse( $txt, :$actions).ast;
    }

    multi method subparse($txt) {
        Text::LDIF::Grammar.subparse($txt).ast;
    }
    multi method subparse($txt, $actions) {
        Text::LDIF::Grammar.subparse($txt, :$actions).ast;
    }

    multi method parsefile($file) {
        Text::LDIF::Grammar.parsefile($file);
    }
    multi method parsefile($file, $actions) {
        Text::LDIF::Grammar.parsefile($file, :$actions);
    }
}
