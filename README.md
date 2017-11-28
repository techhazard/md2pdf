# Generate PDF documents from markdown files

## Introduction
I use this to generate PDF documents from my markdown files.
Being a programmer I am quite comfortable writing and reading markdown, but not all people around me are.
I use this to make stuff better readable for people who do not want to read markdown.

## Dependencies

- `pandoc`
- `texlive-xetex`


## Examples
### Starting point

Let's say we have these files
```sh
$ tree -aF --dirsfirst
.
├── diary/
│   ├── feb/
│   │   ├── 14.markdown
│   │   ├── 15.markdown
│   │   ├── 22.markdown
│   │   └── .pdfdir
│   ├── jan/
│   │   ├── 01.mkd
│   │   ├── 04.mkd
│   │   ├── 07.mkd
│   │   └── .pdfdir
│   └── mar/
│       ├── 13.markdown
│       └── .pdfdir
├── notes/
│   ├── other/
│   │   ├── .pdfdir
│   │   └── some-notes.md
│   └── work-2017-11-09.md
├── personal/
│   ├── movies.md
│   └── .nopdf
└── md2pdf -> ../md2pdf*

7 directories, 16 files
```

### About the special files
#### .pdfdir
if a file called `.pdfdir` is found next to a markdown file,
that directory is used. If it is a relative path, it will be resolved relative to the directory it is in.  
If such a file is not found, a directory called `pdf` is created next to the markdown file and the pdf 
document is placed in that directory.  
In our example:
```sh
$ head -n1  */*/.pdfdir
==> diary/feb/.pdfdir <==
../pdf/feb # diary/feb/../pdf/feb/ -> diary/pdf/feb/

==> diary/jan/.pdfdir <==
../pdf/jan # idem: diary/pdf/jan/

==> diary/mar/.pdfdir <==
../pdf/mar # idem: diary/pdf/mar/

==> notes/other/.pdfdir <==
./ # notes/other/./ -> notes/other/
```

#### .nopdf
If a file called '.nopdf' is found next to a markdown file, the file is skipped and not converted into a pdf.
```sh
$ find . -iname .nopdf
./personal/.nopdf

```

### Running the program
running `./md2pdf --verbose` gives:

```sh
$ ./md2pdf --verbose
generating ./notes/other/some-notes.pdf... done!
generating ./notes/pdf/work-2017-11-09.pdf... done!
generating ./diary/pdf/jan/07.pdf... done!
generating ./diary/pdf/jan/01.pdf... done!
generating ./diary/pdf/jan/04.pdf... done!
generating ./diary/pdf/mar/13.pdf... done!
generating ./diary/pdf/feb/15.pdf... done!
generating ./diary/pdf/feb/14.pdf... done!
generating ./diary/pdf/feb/22.pdf... done!
skipping   ./personal/movies.md (.nopdf found)
```
This results in the following file structure:

```sh
$ tree -aF --dirsfirst
.
├── diary/
│   ├── feb/
│   │   ├── 14.markdown
│   │   ├── 15.markdown
│   │   ├── 22.markdown
│   │   └── .pdfdir
│   ├── jan/
│   │   ├── 01.mkd
│   │   ├── 04.mkd
│   │   ├── 07.mkd
│   │   └── .pdfdir
│   ├── mar/
│   │   ├── 13.markdown
│   │   └── .pdfdir
│   └── pdf/
│       ├── feb/
│       │   ├── 14.pdf
│       │   ├── 15.pdf
│       │   └── 22.pdf
│       ├── jan/
│       │   ├── 01.pdf
│       │   ├── 04.pdf
│       │   └── 07.pdf
│       └── mar/
│           └── 13.pdf
├── notes/
│   ├── other/
│   │   ├── .pdfdir
│   │   ├── some-notes.md
│   │   └── some-notes.pdf
│   ├── pdf/
│   │   └── work-2017-11-09.pdf
│   └── work-2017-11-09.md
├── personal/
│   ├── movies.md
│   └── .nopdf
└── md2pdf -> ../md2pdf*

12 directories, 25 files
```
And now we have neatly made-up PDF documents :-)

If we change one file and run it again we can see that only the changed file is updated.
```sh
$ echo "new text" >> notes/other/some-notes.md
$ ./md2pdf --verbose
generating ./notes/other/some-notes.pdf... done!
skipping   ./notes/pdf/work-2017-11-09.pdf (pdf is newer)
skipping   ./personal/movies.md (.nopdf found)
skipping   ./diary/pdf/jan/07.pdf (pdf is newer)
skipping   ./diary/pdf/jan/01.pdf (pdf is newer)
skipping   ./diary/pdf/jan/04.pdf (pdf is newer)
skipping   ./diary/pdf/mar/13.pdf (pdf is newer)
skipping   ./diary/pdf/feb/15.pdf (pdf is newer)
skipping   ./diary/pdf/feb/14.pdf (pdf is newer)
skipping   ./diary/pdf/feb/22.pdf (pdf is newer)
```
Only `some-notes.md` has been updated :-)
