# Learn sed(1) by rendering Markdown to HTML

# BLANK LINE
/^$/ {
  x
  s/^\n//
  bclose
}

# CODE BLOCKS
/^```/ {
  # Swap pattern and hold spaces
  x
  # If pattern space is not empty, close the tag
  /^$/!bclose
  # If pattern space is empty, prepend <pre>
  s/^$/<pre>/
  # Swap pattern and hold spaces
  x
  # Delete pattern space and continue
  d
}

# If hold space begins with <pre> then jump to :save
x
/^<pre>/ {
  x
  bsave
}
x

# LINKS
/\[[^]][^]]*\]([^)][^)]*)/ {
  s/\[\([^]][^]]*\)\](\([^)][^)]*\))/<a href="\2">\1<\/a>/g
}

# HEADINGS
/^#/ {
  s/^# \(.*\)$/<h1>\1<\/h1>/
  s/^## \(.*\)$/<h2>\1<\/h2>/
  s/^### \(.*\)$/<h3>\1<\/h3>/
}

# TRAILING SPACES LINE BREAKS
/  $/ {
  s/  $/<br \/>/
}

# ORDERED LISTS
/^[0-9][0-9]*\. / {
  # If hold space does not contain <ol>, add a <ol>
  x
  /<ol>/!s/$/\n<ol>/
  x
  # Render /^[0-9][0-9]*\. / as <li>
  s/^[0-9][0-9]*\. \(.*\)$/<li>\1<\/li>/
}

# UNORDERED LISTS
/^[-*] / {
  # If hold space does not contain <ul>, add a <ul>
  x
  /<ul>/!s/^$/<ul>/
  x
  # Render /^[-*] / as <li>
  s/^[-*] \(.*\)$/<li>\1<\/li>/
}

:save

# NOT BLANK
# If pattern space is not blank, append to hold space and swap
/^$/! {
  H
  x
  s/^\n//
}

# NOT LAST LINE
# If not last line, swap pattern to hold space and end
$! {
  x
  d
}

:close

# EMPTY
# If pattern space is empty, delete and continue
/^$/d

# NOT A TAG
# If pattern space does not begin with <, render as <p>
/^</! {
  s/^\([^<].*\)/<p>\1<\/p>/
}

# Close open tags: ul, ol, pre
s/<ol>.*$/&<\/ol>\n/
s/<ul>.*$/&<\/ul>\n/
s/<pre>.*$/&<\/pre>\n/

# INLINE TEXT FORMATTING
# Change ` pairs to <code>
/[^`]`[^`][^`]*`[^`]/ {
  s/\([^`]\)`\([^`][^`]*\)`\([^`]\)/\1<code>\2<\/code>\3/g
}
# Change _ pairs to <i>
/[^_]_[^_][^_]*_[^_]/ {
  s/\([^_]\)_\([^_][^_]*\)_\([^_]\)/\1<i>\2<\/i>\3/g
}
# Change * pairs to <b>
/[^*]\*[^*][^*]*\*[^*]/ {
  s/\([^\*]\)\*\([^\*][^\*]*\)\*\([^\*]\)/\1<b>\2<\/b>\3/g
}

# Clear hold space
x
s/.*//g
x
