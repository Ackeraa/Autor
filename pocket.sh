#!/bin/bash
# Get today's read later from pocket

POCKET_CONSUMER_KEY=103832-c81ca11815cdf836e59d45d
POCKET_ACCESS_TOKEN=a70c9106-7080-5ebc-8d21-eb0fbc

today=$(TZ=UTC-8 date -d "$(date +'%Y-%m-%d') 00:00:00" +%s)

items=$(curl --silent -X POST https://getpocket.com/v3/get \
	     -d "consumer_key=$POCKET_CONSUMER_KEY&access_token=$POCKET_ACCESS_TOKEN&since=$today" \
	     | sed 's/",/",\n/g' \
	     | sed 's/,"/,\n"/g' \
	     | sed -n '/"given_title"\|"given_url"/p' \
	     | sed 's/\\\//\//g')
IFS=$'\n'
titles=($(echo "$items" | sed -n '/"given_title"/p' | sed -E 's/"given_title":|",|"//g'))
urls=($(echo "$items" | sed -n '/"given_url"/p' | sed -E 's/"given_url":|",|"//g'))

if [ ${#titles[*]} -gt 0 ]
then
    echo '<div class="title">Pocket</div> <div class="content">'
    for (( i = 0; i < ${#titles[*]}; i++ ))
    do
	echo -e "<p><a href='${urls[$i]}'>${titles[$i]}</a></p>"
    done

    echo '</div>'
fi
