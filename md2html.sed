# Learn sed(1) by rendering Markdown to HTML

# If pattern space is blank, swap it with hold space
# If pattern space begins with \n, remove that \n
# Then close the tag pattern space begins with
/^$/ {
  x
  s/^\n//
  bclose
}

# HEADINGS
/^#/ {
  s/^# \(.*\)$/<h1>\1<\/h1>/
  s/^## \(.*\)$/<h2>\1<\/h2>/
  s/^### \(.*\)$/<h3>\1<\/h3>/
  bclear
}

# TRAILING LINE BREAKS
/  $/ {
  s/  $/<br \/>/
}

# ORDERED LISTS
/^[0-9][0-9]*\. / {
  # If hold space is empty, prepend <ol>
  x
  s/^$/<ol>/
  x
  # Render /^[0-9][0-9]*\. / as <li>
  s/^[0-9][0-9]*\. \(.*\)$/<li>\1<\/li>/
}

# UNORDERED LISTS
/^[-*] / {
  # If hold space is empty, prepend <ul>
  x
  s/^$/<ul>/
  x
  # Render /^[-*] / as <li>
  s/^[-*] \(.*\)$/<li>\1<\/li>/
}

# If pattern space is not blank, append to hold space and swap
/^$/! {
  H
  x
  s/^\n//
}

#
# Default to PARAGRAPH
#
# If pattern space does not begin with <, render as <p>
/^</! {
  s/^\([^<].*\)/<p>\1/
}

# If not last line, swap pattern to hold space and end
$! {
  x
  d
}

:close
# Close the tag pattern space begins with
s/^<\([^>]*\)>.*$/&<\/\1>\n/

:clear
# Clear hold space
x
s/.*//g
x
