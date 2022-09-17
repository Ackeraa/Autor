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

    # Get rss source
    echo "$content" \
	| sed -n '/<title>/{p; q}' \
	| grep -o '<title>.*</title>' \
	| sed 's/title>/h3>/g' > $newrf

    # Get items
    items=$(echo "$content" \
	    | tr "\n" "|" \
	    | grep -o '<item>.*</item>' \
	    | sed 's/<item>\|<\/item>//g; s/|/\n/g' \
	    | sed 's/title>/h2>/g' \
	    | sed 's/<link>/<p><a href="/; s/<\/link>/">LINK<\/a><\/p>/' \
	    | sed 's/<\!\[CDATA\[//g; s/\]\]>//g' \
	    | sed 's/pubDate>/p>/g')
    IFS=$'\n'
    titles=($(echo "$items" | sed -n '/h2>/p'))
    contents=($(echo "$items" | sed '/h2>/d'))
    for (( i = 0; i < ${#titles[*]}; i++ ))
    do
	echo "${titles[$i]}" >> $newrf
	echo "<div class='content'>${contents[$i]}</div>" >> $newrf
    done
    cmp --silent  $oldrf $newrf || cat $newrf >> $outputf && mv $newrf $oldrf
    i=$[$i+1]
done
