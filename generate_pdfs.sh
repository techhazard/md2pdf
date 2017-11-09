#!/bin/bash

if ! (command -v pandoc >/dev/null 2>&1 && command -v latex >/dev/null 2>&1); then
	echo "Please install pandoc and texlive" >&2
	exit 1
fi

markdown_files=$(find . -iname '*.md' -or -iname '*.mkd' -or -iname '*.markdown')

for file in $markdown_files; do
	# skip if a .nopdf file is found in the same directory
	[[ -f "$(dirname $file)/.nopdf" ]] && echo "skipping $file" >&2 && continue

	document="$(dirname ${file})/pdf/$(basename ${file%.*}.pdf)"

	filetime=$(stat --printf=%Y $file)
	docutime=$(stat --printf=%Y $document 2>/dev/null)

	# only need to genearate if the markdown file is newer than the PDF
	if [[ "$filetime" -gt "$docutime" ]]; then
		mkdir -p $(dirname $document)
		echo -n "generating ${document}..."
		pandoc -f markdown -t latex -o $document $file || exit
		echo " done!"
	fi
done

