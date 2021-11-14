# Learn sed(1) by rendering Markdown to HTML

s/^# \(.*\)$/<h1>\1<\/h1>/
s/^## \(.*\)$/<h2>\1<\/h2>/
s/^### \(.*\)$/<h3>\1<\/h3>/

s/^\(.*\)  $/<p>\1<\/p>/
