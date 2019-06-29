use v6;

use Text::LDIF::Grammar;
use Text::LDIF::Actions;

class Text::LDIF {
    method parse(Str $txt) {
        my $text = $txt.subst(/"\n "/, '', :g).subst(/'#' .*? "\n"/, "", :g);
        Text::LDIF::Grammar.parse($text, actions => Text::LDIF::Actions).ast;
    }
}
