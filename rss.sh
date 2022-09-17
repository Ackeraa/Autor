#!/bin/bash
# Getting rss located in path config/ ,
# which should be specified in the arguments.

__dir=$(dirname "$0")
outputf=$__dir/data/rss.html
rssf=$__dir/config/$1
echo > $outputf

rss=$(cat $rssf | tr -d "\n" | grep -o "<rss>.*</rss>" | sed 's/<rss>\|<\/rss>//g' | tr -s ' ')
i=1
for link in $rss
do
    oldrf=$__dir/data/rss$i.html
    newrf=$__dir/data/rss$i\_.html

    content=$(curl $link -H "User-Agent: Mozilla/4.0")

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
    cmp --silent  $oldrf $newrf || cat $newrf >> $outputf && mv $newrf $oldrf
    i=$[$i+1]
done
