# Generate PDFs from markdown files

I use this to generate PDF documents from my markdown files.
Being a programmer I am quite comfortable writing and reading markdown, but not all people around me are.
I use this to make stuff better readable for non-programmers


## Examples

Let's say we have these files
```sh
$ tree -a -F --dirsfirst
.
├── diary/
│   ├── feb/
│   │   ├── 14.markdown
│   │   ├── 15.markdown
│   │   └── 22.markdown
│   ├── jan/
│   │   ├── 01.mkd
│   │   ├── 04.mkd
│   │   └── 07.mkd
│   └── mar/
│       ├── 13.markdown
│       └── .nopdf
├── notes/
│   └── work-2017-11-09.md
└── generate_pdfs.sh -> ../generate_pdfs.sh*
5 directories, 10 files
```
running `./generate_pdfs.sh` gives:

```sh
$ ./generate_pdfs.sh
generating ./diary/jan/pdf/04.pdf... done!
generating ./diary/jan/pdf/01.pdf... done!
generating ./diary/jan/pdf/07.pdf... done!
generating ./diary/feb/pdf/15.pdf... done!
generating ./diary/feb/pdf/22.pdf... done!
generating ./diary/feb/pdf/14.pdf... done!
skipping ./diary/mar/13.markdown
generating ./notes/pdf/work-2017-11-09.pdf... done!

$ tree -a -F --dirsfirst
.
├── diary/
│   ├── feb/
│   │   ├── pdf/
│   │   │   ├── 14.pdf
│   │   │   ├── 15.pdf
│   │   │   └── 22.pdf
│   │   ├── 14.markdown
│   │   ├── 15.markdown
│   │   └── 22.markdown
│   ├── jan/
│   │   ├── pdf/
│   │   │   ├── 01.pdf
│   │   │   ├── 04.pdf
│   │   │   └── 07.pdf
│   │   ├── 01.mkd
│   │   ├── 04.mkd
│   │   └── 07.mkd
│   └── mar/
│       ├── 13.markdown
│       └── .nopdf
├── notes/
│   ├── pdf/
│   │   └── work-2017-11-09.pdf
│   └── work-2017-11-09.md
└── generate_pdfs.sh -> ../generate_pdfs.sh*
8 directories, 17 files
```
