s/^keycode \+\([0-9]\+\) = \([^ ]*\) \([^ ]*\).*/\1 \2 \3/
/^keycode/d
s/ NoSymbol$//
s/\<exclam\>/!/
s/\<at\>/@/
s/\<numbersign\>/#/
s/\<dollar\>/$/
s/\<percent\>/%/
s/\<asciicircum\>/^/
s/\<ampersand\>/\\\&amp;/
s/\<asterisk\>/*/
s/\<parenleft\>/(/
s/\<parenright\>/)/
s/\<minus\>/-/
s/\<underscore\>/_/
s/\<equal\>/=/
s/\<plus\>/+/
s/\<bracketleft\>/[/
s/\<braceleft\>/{/
s/\<bracketright\>/]/
s/\<braceright\>/}/
s/\<semicolon\>/;/
s/\<colon\>/:/
s/\<apostrophe\>/'/
s/\<quotedbl\>/"/
s/\<grave\>/`/
s/\<asciitilde\>/~/
s/\<backslash\>/\\\\/
s/\<bar\>/|/
s/\<comma\>/,/
s/\<less\>/\\\&lt;/
s/\<period\>/./
s/\<greater\>/\\\&gt;/
s/\<slash\>/\\\//
s/\<question\>/?/
s/\(Tab\|Shift\|Control\|Super\|Alt\).*/\1/

# If both are the same, then it is just one
s/^\([0-9]\+\) \([^ ]*\) \2/\1 \2/

# When letters are both the same, use just the second one (usually capital one)
s/^\([0-9]\+\) \([^ ]\) \(\2\)/\1 \3/I

s/^\([0-9]\+\) \([^ ]\)$/s\/\\(id="kc_\1".*\\)_\/\\1<text text-anchor="start" font-family="Monospace" font-size="10" x="2" y="11">\2<\\\/text>\//
s/^\([0-9]\+\) \([^ ]\+\)$/s\/\\(id="kc_\1".*\\)_\/\\1<text text-anchor="start" font-family="Monospace" font-size="5" x="2" y="6">\2<\\\/text>\//
s/^\([0-9]\+\) \([^ ]*\) \([^ ]*\)$/s\/\\(id="kc_\1".*\\)_\/\\1<text text-anchor="start" font-family="Monospace" font-size="7" x="2" y="8">\3<\\\/text><text text-anchor="start" font-family="Monospace" font-size="7" x="2" y="16">\2<\\\/text>\//
# Yes. This sed script generates sed script.
