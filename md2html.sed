# Learn sed(1) by rendering Markdown to HTML

# Render /^#{1,3} / as <h1>-<h3>
/^#/ {
  s/^# \(.*\)$/<h1>\1<\/h1>/
  s/^## \(.*\)$/<h2>\1<\/h2>/
  s/^### \(.*\)$/<h3>\1<\/h3>/
}

# Render /^.*  $/ as <p>
/  $/ {
  s/^\(.*\)  $/<p>\1<\/p>/
}

# TODO: How to handle when the last line is a blank line?
# TODO: How to handle when the last line is not a blank line?

# If pattern space is a blank line, swap it with hold space
# If pattern space begins with \n, remove that \n
# If pattern space does not begin with <, render it as <p>
/^$/ {
  x
  s/^\n//
  s/^\([^<].*\)/<p>\1<\/p>\n/
}

# If pattern space does not begin with <, append it to hold space
# Then delete pattern space and continue
/^[^<].*/ {
  H
  d
}
