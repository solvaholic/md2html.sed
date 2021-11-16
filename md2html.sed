# Learn sed(1) by rendering Markdown to HTML

# If pattern space is blank, swap it with hold space
# If pattern space begins with \n, remove that \n
# Then close the tag pattern space begins with
/^$/ {
  x
  s/^\n//
  bclose
}

# If pattern space is not blank, append to hold space and swap
/^$/! {
  H
  x
  s/^\n//
}

# Render /^#{1,3} / as <h1>-<h3>
/^#/ {
  s/^# \(.*\)$/<h1>\1<\/h1>/
  s/^## \(.*\)$/<h2>\1<\/h2>/
  s/^### \(.*\)$/<h3>\1<\/h3>/
  bclear
}

# Render /  $/ as <br />
/  $/ {
  s/  $/<br \/>/
}

# If pattern space does not begin with <, render it as <p>
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
