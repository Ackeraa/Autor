#!/bin/bash
# Getting rss listed in data/rsslist

__dir=$(dirname "$0")
rssf=$__dir/data/rss.html
agent="Mozilla/4.0"
echo > $rssf

i=1
for link in $(cat $__dir/config/rsslist)
do
    oldrf=$__dir/data/rss$i.html
    newrf=$__dir/data/rss$i\_.html

    content=$(curl $link -H "User-Agent: $agent")

    # Get title
    echo "$content" \
	| sed -n '/<title>/{p; q}' \
	| grep -o '<title>.*</title>' \
	| sed 's/title>/h3>/g' > $newrf

    # Get item
    echo "$content" \
	| tr "\n" "|" \
	| grep -o '<item>.*</item>' \
	| sed 's/<item/<div class="content"/g; s/\/item>/\/div>/g; s/|/\n/g' \
	| sed 's/title>/h4>/g' \
	| sed 's/<link>/<p><a href="/; s/<\/link>/">\&#11208;<\/a><\/p>/' \
	| sed 's/<\!\[CDATA\[//g; s/\]\]>//g' \
	| sed 's/pubDate>/p>/g' >> $newrf
    cmp --silent  $oldrf $newrf || cat $newrf >> $rssf && mv $newrf $oldrf
    i=$[$i+1]
done
