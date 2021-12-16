# md2html.sed

Learn [sed(1)](https://en.wikipedia.org/wiki/Sed) by rendering [Markdown](https://en.wikipedia.org/wiki/Markdown) to [HTML](https://en.wikipedia.org/wiki/HTML)

(And also by reading [the O'Reilly _sed & awk_ book](https://www.oreilly.com/library/view/sed-awk/1565922255/))

## Use md2html.sed

```bash
sed -f md2html.sed test.md
```

## Test `md2html.sed`

```bash
diff -B <(sed -f md2html.sed test.md) test.html
diff <(sed -f md2html.sed test.md) <(gsed -f md2html.sed test.md)
sed -f md2html.sed README.md
```

## Modify `md2html.sed`

1. Make sure the script tests successfully, before changing it
1. Add or modify Markdown in `test.md`
1. Add or modify corresponding HTML in `test.html`
1. Add or modify commands to render Markdown to HTML in `md2html.sed`
1. Update README.md, if it's no longer correct
1. Make sure the script tests successfully, after changing it

## Which Markdown features are supported?

`md2html.sed` supports a small subset of Markdown features. See
`test.md` for the current list.

## `md2html.sed` should support ____

Kindly share your feedback in a [pull request](https://docs.github.com/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests) or an [issue](https://docs.github.com/issues/tracking-your-work-with-issues/about-issues) :bow:


## How does `md2html.sed` work?

### Expectations/Assumptions

In Markdown, use blank lines between different formats and layouts.

When script begins or ends, hold space contains all pending output.

### Steps

1. If pattern space is blank then swap hold to pattern and jump to :close
1. If pattern begins with ``` then start or end a pre
1. If hold space contains a pre tag then jump to :save
1. Render links
1. Render headings
1. Render trailing spaces line breaks
1. Render ordered lists
1. Render unordered lists
1. [:save] If pattern is not blank, append to hold and swap
1. If not last line, swap pattern to hold and end
1. [:close] If pattern is blank, delete and continue
1. If pattern does not begin with <, render as p
1. Close some opening tags: ol, ul, pre
1. Render inline formatting: ` _ *
1. Clear hold space
