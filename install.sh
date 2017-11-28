#!/bin/bash
link="$(/usr/bin/ls -la ~/bin/md2pdf 2>/dev/null)"
set -e
mkdir -p ~/bin
path="$(dirname "$(realpath -e "$0")")"

if [[ "$link" != "" ]]; then
	link_filetype="${link:0:1}"
	if [[ "$link_filetype" == "l" ]]; then
		link_target="$(echo "$link" | awk '{print $11}')"
		if [[ "$link_target" == "$path/md2pdf" ]]; then
			echo "already installed"
			exit 0;
		fi
	else
		echo "File ~/bin/md2pdf already exists and is not a link, will not overwrite file" >&2
		exit 1
	fi
fi
ln -s "${path}/md2pdf" "${HOME}/bin/md2pdf" 2>/dev/null && echo "succesfully installed in ~/bin/md2pdf !" || echo "md2pdf appears to be installed already..."

