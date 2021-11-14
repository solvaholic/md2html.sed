# md2html.sed
Learn sed(1) by rendering Markdown to HTML

## Use md2html.sed
```bash
sed -f md2html.sed test.md
```

## Add new capability to `md2html.sed`
1. Make sure the script tests successfully, before changing it
1. Add your new Markdwon to `test.md`
1. Add corresponding HTML to `test.html`
1. Add commands to render Markdown to HTML, in `md2html.sed`
1. Make sure the script tests successfully, after changing it

## Test `md2html.sed`
```bash
diff -B <(sed -f md2html.sed test.md) test.html
```

## Which Markdown features are supported?
`md2html.sed` supports a small subset of Markdown features. See `test.md` for the current list.
