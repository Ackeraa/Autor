#!/bin/bash
# Getting rss located in path config/ ,
# which should be specified in the arguments.

today=$(date -d '-1 day') 

i=1
for rss in "$@"
do
    xml=$(curl --silent "$rss" -H "User-Agent: Mozilla/4.0")
    is_update=0

    IFS=$'\n'
    content=$(echo "$xml" \
	| tr "\n" "|" \
	| grep -o '<item>.*</item>' \
	| sed 's/<item>\|<\/item>/\n/g' \
	| sed 's/title>/h3>/g' \
	| sed 's/<link>/<p><a href="/; s/<\/link>/">LINK<\/a><\/p>/g' \
	| sed 's/<\!\[CDATA\[//g; s/\]\]>//g')

    for item in $content
    do
	pdate=$(echo $item \
	    | grep -o "<pubDate>.*</pubDate>" \
	    | sed 's/<pubDate>\|<\/pubDate>//g')
	if [ "$pdate" != "" ] && [ $(date -d $pdate +%s) -gt $(date -d $today +%s) ]
	then
	    # Only report the rss which update tody.
	    if [ $is_update -eq 0 ];
	    then
		is_update=1

		# Get rss source
		echo "$xml" \
		    | sed -n '/<title>/{p; q}' \
		    | grep -o '<title>.*</title>' \
		    | sed 's/title>/h2>/g'

		# Get rss content
		echo '<div class="content">'
	    fi

	    echo "$item" | sed 's/|/\n/g; s/pubDate>/p>/g'
	fi
    done

    if [ $is_update -eq 1 ];
    then
	echo '</div>'
    fi

    i=$[$i+1]
done
