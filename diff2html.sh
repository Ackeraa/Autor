#!/bin/bash
# Convert diff output to colorized HTML.
# Forked from https://gist.github.com/stopyoukid/5888146

html="<div>"
first=1
diffseen=0
lastonly=0
currSection=''
currFile=''

function addDiffToPage {
  html+="<h2>"$1"</h2>"
	html+="<div class=\"file-diff\">"
	html+=$2
	html+="</div>"
}

OIFS=$IFS
IFS='
'

# The -r option keeps the backslash from being an escape char.
read -r s

while [[ $? -eq 0 ]]; do
	# Get beginning of line to determine what type of diff line it is.
	t1=${s:0:1}
	t2=${s:0:2}
	t3=${s:0:3}
	t4=${s:0:4}
	t7=${s:0:7}

	# Determine HTML class to use.
	if    [[ "$t7" == 'Only in' ]]; then
		cls='only'

		if [[ $diffseen -eq 0 ]]; then
			diffseen=1
		else
			if [[ $lastonly -eq 0 ]]; then
                addDiffToPage $currFile $currSection
			fi
		fi

		if [[ $lastonly -eq 0 ]]; then
			currSection=""
		fi
		lastonly=1

	elif [[ "$t4" == 'diff' ]]; then
		cls='file'
		if [[ $diffseen -eq 1 ]]; then
            addDiffToPage $currFile $currSection
		fi

		diffseen=1
		currSection=""
		lastonly=0

	elif  [[ "$t3" == '+++' ]]; then
        # --- always comes before +++
	#	currFile=${s#+++ */}
		cls='insert'
		lastonly=0

	elif  [[ "$t3" == '---' ]]; then
		currFile=${s#--- */}
		cls='delete'
		lastonly=0

	elif  [[ "$t2" == '@@' ]]; then
		cls='info'
		lastonly=0

	elif  [[ "$t1" == '+' ]]; then
		cls='insert'
		lastonly=0

	elif  [[ "$t1" == '-' ]]; then
		cls='delete'
		lastonly=0

	else
		cls='context'
		lastonly=0
	fi
	
	# Convert &, <, > to HTML entities.
	s=$(sed -e 's/\&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g' <<<"$s")
	if [[ $first -eq 1 ]]; then
		first=0
	fi

	# Output the line.
	if [[ "$cls" ]]; then
		currSection+='<pre class="'${cls}'">'${s}'</pre>'
	else
		currSection+='<pre>'${s}'</pre>'
	fi
	
	read -r s
done

#if [[ $diffseen -eq 1  &&  $onlyseen -eq 0 ]]; then 
if [[ "$currSection" ]]; then
    addDiffToPage $currFile $currSection
fi
html+="</div>"
echo "$html"

IFS=$OIFS
