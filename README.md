# md2html.sed
Learn [sed(1)](https://en.wikipedia.org/wiki/Sed) by rendering [Markdown](https://en.wikipedia.org/wiki/Markdown) to [HTML](https://en.wikipedia.org/wiki/HTML)

(And also by reading [the O'Reilly _sed & awk_ book](https://www.oreilly.com/library/view/sed-awk/1565922255/))

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

```bash
diff <(sed -f md2html.sed test.md) <(gsed -f md2html.sed test.md)
```

## Which Markdown features are supported?
`md2html.sed` supports a small subset of Markdown features. See
`test.md` for the current list.

## `md2html.sed` should support ____
`md2html.sed` is a learning exercise, not a comprehensive Markdown rendering tool. `md2html.sed` will be complete when it can render its own README as HTML.
